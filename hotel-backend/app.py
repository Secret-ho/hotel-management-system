from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
import os
from dotenv import load_dotenv
import hashlib
import secrets

load_dotenv()

app = Flask(__name__)
CORS(app)  # اجازه می‌ده فرانت بتونه به API وصل بشه

# ─── اتصال به دیتابیس ────────────────────────────────────────────────────────

def get_db():
    """یه connection جدید به MySQL می‌سازه"""
    conn = mysql.connector.connect(
        host=os.getenv("DB_HOST", "localhost"),
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", "hossein2006"),
        database=os.getenv("DB_NAME", "hotelmanagementsystem")
    )
    cursor = conn.cursor()
    cursor.execute("SET @current_username = 'admin'")
    cursor.close()
    return conn


def query(sql, params=(), fetchone=False):
    """یه helper ساده برای SELECT"""
    conn = get_db()
    cur = conn.cursor(dictionary=True)
    cur.execute(sql, params)
    result = cur.fetchone() if fetchone else cur.fetchall()
    cur.close()
    conn.close()
    return result


def execute(sql, params=()):
    """یه helper ساده برای INSERT / UPDATE / DELETE"""
    conn = get_db()
    cur = conn.cursor()
    cur.execute(sql, params)
    conn.commit()
    last_id = cur.lastrowid
    cur.close()
    conn.close()
    return last_id


def call_proc(proc_name, args=()):
    """Stored Procedure صدا می‌زنه"""
    conn = get_db()
    cur = conn.cursor(dictionary=True)
    cur.callproc(proc_name, args)
    results = []
    for result_set in cur.stored_results():
        results.extend(result_set.fetchall())
    conn.commit()
    cur.close()
    conn.close()
    return results


# ─── هتل‌ها ──────────────────────────────────────────────────────────────────

@app.route("/api/hotels", methods=["GET"])
def get_hotels():
    """لیست همه هتل‌ها"""
    hotels = query("SELECT * FROM hotel ORDER BY star_rating DESC")
    return jsonify(hotels)


@app.route("/api/hotels/<int:hotel_id>", methods=["GET"])
def get_hotel(hotel_id):
    """اطلاعات یه هتل خاص"""
    hotel = query("SELECT * FROM hotel WHERE hotel_id = %s", (hotel_id,), fetchone=True)
    if not hotel:
        return jsonify({"error": "هتل پیدا نشد"}), 404
    return jsonify(hotel)


@app.route("/api/hotels/five-star", methods=["GET"])
def get_five_star_hotels():
    """هتل‌های ۵ ستاره — از Stored Procedure"""
    hotels = call_proc("GetFiveStarHotels")
    return jsonify(hotels)


# ─── اتاق‌ها ─────────────────────────────────────────────────────────────────

@app.route("/api/rooms", methods=["GET"])
def get_rooms():
    """لیست اتاق‌ها — با فیلتر اختیاری hotel_id"""
    hotel_id = request.args.get("hotel_id")
    if hotel_id:
        rooms = query(
            """SELECT r.*, rt.type_name, rt.capacity
               FROM room r
               JOIN roomtype rt ON r.room_type_id = rt.room_type_id
               WHERE r.hotel_id = %s
               ORDER BY r.floor_number, r.room_number""",
            (hotel_id,)
        )
    else:
        rooms = query(
            """SELECT r.*, rt.type_name, rt.capacity
               FROM room r
               JOIN roomtype rt ON r.room_type_id = rt.room_type_id
               ORDER BY r.hotel_id, r.floor_number"""
        )
    return jsonify(rooms)


@app.route("/api/rooms/available", methods=["GET"])
def get_available_rooms():
    """اتاق‌های خالی — از Stored Procedure"""
    rooms = call_proc("GetEmptyRooms")
    return jsonify(rooms)


@app.route("/api/rooms/<int:room_id>/status", methods=["PUT"])
def update_room_status(room_id):
    """تغییر وضعیت اتاق — از Stored Procedure"""
    data = request.get_json()
    new_status = data.get("status")

    valid = ["empty", "occupied", "reserved", "cleaning"]
    if new_status not in valid:
        return jsonify({"error": f"وضعیت معتبر نیست. مقادیر مجاز: {valid}"}), 400

    call_proc("UpdateRoomStatus", (room_id, new_status))
    return jsonify({"message": "وضعیت اتاق بروز شد"})


# ─── مشتریان ─────────────────────────────────────────────────────────────────

@app.route("/api/customers", methods=["GET"])
def get_customers():
    """لیست مشتریان"""
    customers = query(
        "SELECT customer_id, first_name, last_name, national_id, mobile_phone, email, membership_level, total_stays FROM customer"
    )
    return jsonify(customers)


@app.route("/api/customers/<int:customer_id>", methods=["GET"])
def get_customer(customer_id):
    """اطلاعات یه مشتری"""
    customer = query(
        "SELECT * FROM customer WHERE customer_id = %s", (customer_id,), fetchone=True
    )
    if not customer:
        return jsonify({"error": "مشتری پیدا نشد"}), 404
    return jsonify(customer)


@app.route("/api/customers", methods=["POST"])
def add_customer():
    """ثبت مشتری جدید — از Stored Procedure"""
    data = request.get_json()

    required = ["first_name", "last_name", "national_id", "mobile_phone"]
    missing = [f for f in required if not data.get(f)]
    if missing:
        return jsonify({"error": f"فیلدهای اجباری: {missing}"}), 400

    call_proc("AddCustomer", (
        data["first_name"],
        data["last_name"],
        data["national_id"],
        data["mobile_phone"]
    ))
    new_customer = query(
        "SELECT customer_id FROM customer WHERE national_id = %s",
        (data["national_id"],),
        fetchone=True
    )
    return jsonify({
        "message": "مشتری با موفقیت ثبت شد",
        "customer_id": new_customer["customer_id"] if new_customer else None
    }), 201


@app.route("/api/customers/gold-count", methods=["GET"])
def count_gold_customers():
    """تعداد مشتریان Gold — از Stored Procedure"""
    result = call_proc("CountGoldCustomers")
    return jsonify(result[0] if result else {"gold_members": 0})


# ─── رزروها ──────────────────────────────────────────────────────────────────

@app.route("/api/reservations", methods=["GET"])
def get_reservations():
    customer_id = request.args.get("customer_id")
    if customer_id:
        reservations = call_proc("GetCustomerReservations", (int(customer_id),))
    else:
        reservations = query("SELECT * FROM reservation ORDER BY check_in_date DESC")
    return jsonify(reservations)


@app.route("/api/reservations/upcoming", methods=["GET"])
def get_upcoming_reservations():
    """رزروهای ۷ روز آینده"""
    reservations = query(
        """SELECT reservation_number, check_in_date, check_out_date
           FROM reservation
           WHERE check_in_date >= CURDATE()
           AND check_in_date <= CURDATE() + INTERVAL 7 DAY
           AND status = 'confirmed'
           ORDER BY check_in_date"""
    )
    return jsonify(reservations)


@app.route("/api/reservations", methods=["POST"])
def create_reservation():
    """رزرو جدید — از Transaction که atomicه"""
    data = request.get_json()

    required = ["reservation_number", "customer_id", "room_id",
                "check_in_date", "check_out_date", "total"]
    missing = [f for f in required if not data.get(f)]
    if missing:
        return jsonify({"error": f"فیلدهای اجباری: {missing}"}), 400

    try:
        call_proc("CreateReservationTransaction", (
            data["reservation_number"],
            data["customer_id"],
            data["room_id"],
            data["check_in_date"],
            data["check_out_date"],
            data["total"]
        ))
        return jsonify({"message": "رزرو با موفقیت ثبت شد"}), 201
    except Error as e:
        return jsonify({"error": str(e)}), 400


@app.route("/api/reservations/<int:reservation_id>/cancel", methods=["POST"])
def cancel_reservation(reservation_id):
    """لغو رزرو — از Transaction"""
    try:
        call_proc("CancelReservationTransaction", (reservation_id,))
        return jsonify({"message": "رزرو لغو شد"})
    except Error as e:
        return jsonify({"error": str(e)}), 400


# ─── فاکتور و پرداخت ─────────────────────────────────────────────────────────

@app.route("/api/invoices", methods=["GET"])
def get_invoices():
    """لیست فاکتورها"""
    status = request.args.get("status")  # مثلاً ?status=unsettled
    if status:
        invoices = query(
            "SELECT * FROM invoice WHERE status = %s ORDER BY invoice_id DESC",
            (status,)
        )
    else:
        invoices = query("SELECT * FROM invoice ORDER BY invoice_id DESC")
    return jsonify(invoices)


@app.route("/api/invoices/unsettled", methods=["GET"])
def get_unsettled_invoices():
    """فاکتورهای پرداخت نشده — از Stored Procedure"""
    invoices = call_proc("GetUnsettledInvoices")
    return jsonify(invoices)


@app.route("/api/payments", methods=["POST"])
def register_payment():
    """ثبت پرداخت — از Transaction"""
    data = request.get_json()

    required = ["payment_number", "invoice_id", "reservation_id", "amount"]
    missing = [f for f in required if not data.get(f)]
    if missing:
        return jsonify({"error": f"فیلدهای اجباری: {missing}"}), 400

    try:
        call_proc("RegisterPaymentTransaction", (
            data["payment_number"],
            data["invoice_id"],
            data["reservation_id"],
            data["amount"]
        ))
        return jsonify({"message": "پرداخت با موفقیت ثبت شد"}), 201
    except Error as e:
        return jsonify({"error": str(e)}), 400


# ─── گزارش‌ها ─────────────────────────────────────────────────────────────────

@app.route("/api/reports/revenue", methods=["GET"])
def get_total_revenue():
    """درآمد کل — از Stored Procedure"""
    result = call_proc("CalculateTotalRevenue")
    return jsonify(result[0] if result else {"total_revenue": 0})


@app.route("/api/reports/room-stats", methods=["GET"])
def get_room_stats():
    """آمار اتاق‌ها به تفکیک نوع"""
    stats = query(
        """SELECT rt.type_name, AVG(r.standard_price_per_night) AS avg_price,
                  COUNT(*) AS total_rooms,
                  SUM(CASE WHEN r.status = 'empty' THEN 1 ELSE 0 END) AS empty_rooms
           FROM room r
           JOIN roomtype rt ON r.room_type_id = rt.room_type_id
           GROUP BY rt.room_type_id, rt.type_name"""
    )
    return jsonify(stats)


@app.route("/api/reports/hotel-rating/<int:hotel_id>", methods=["GET"])
def get_hotel_rating(hotel_id):
    """میانگین امتیاز هتل — از Function"""
    result = query(
        "SELECT get_hotel_average_rating(%s, 'overall') AS overall, "
        "get_hotel_average_rating(%s, 'room') AS room, "
        "get_hotel_average_rating(%s, 'service') AS service, "
        "get_hotel_average_rating(%s, 'staff') AS staff",
        (hotel_id, hotel_id, hotel_id, hotel_id),
        fetchone=True
    )
    return jsonify(result)


# ─── احراز هویت ──────────────────────────────────────────────────────────────

@app.route("/api/auth/login", methods=["POST"])
def login():
    """ورود کاربر"""
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")

    if not username or not password:
        return jsonify({"error": "نام کاربری و رمز عبور الزامی است"}), 400

    # رمز رو hash می‌کنیم (ساده — در پروژه واقعی از bcrypt استفاده کن)
    password_hash = hashlib.sha256(password.encode()).hexdigest()

    user = query(
        "SELECT user_id, username, role, hotel_id FROM users WHERE username = %s AND password_hash = %s",
        (username, password_hash),
        fetchone=True
    )

    if not user:
        return jsonify({"error": "نام کاربری یا رمز عبور اشتباه است"}), 401

    # یه token ساده می‌سازیم (در پروژه واقعی از JWT استفاده کن)
    token = secrets.token_hex(32)
    return jsonify({"token": token, "user": user})


# ─── اجرا ────────────────────────────────────────────────────────────────────

if __name__ == "__main__":
    app.run(debug=True, port=5000)
