USE hotelmanagementsystem;

DELIMITER //

-- =====================================================
-- 1. Show all empty rooms
-- =====================================================

CREATE PROCEDURE GetEmptyRooms()
BEGIN
    SELECT room_number,
           floor_number,
           standard_price_per_night
    FROM room
    WHERE status = 'empty';
END //

-- =====================================================
-- 2. Show reservations of a customer
-- =====================================================

CREATE PROCEDURE GetCustomerReservations(
    IN p_customer_id INT
)
BEGIN
    SELECT reservation_number,
           check_in_date,
           check_out_date,
           status
    FROM reservation
    WHERE customer_id = p_customer_id;
END //

-- =====================================================
-- 3. Calculate total hotel revenue
-- =====================================================

CREATE PROCEDURE CalculateTotalRevenue()
BEGIN
    SELECT SUM(grand_total) AS total_revenue
    FROM invoice
    WHERE status = 'settled';
END //

-- =====================================================
-- 4. Show unpaid invoices
-- =====================================================

CREATE PROCEDURE GetUnsettledInvoices()
BEGIN
    SELECT invoice_number,
           grand_total,
           remaining_amount
    FROM invoice
    WHERE status = 'unsettled';
END //

-- =====================================================
-- 5. Update room status
-- =====================================================

CREATE PROCEDURE UpdateRoomStatus(
    IN p_room_id INT,
    IN p_new_status VARCHAR(20)
)
BEGIN
    UPDATE room
    SET status = p_new_status
    WHERE room_id = p_room_id;
END //

-- =====================================================
-- 6. Add new customer
-- =====================================================

CREATE PROCEDURE AddCustomer(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_national_id VARCHAR(20),
    IN p_mobile_phone VARCHAR(20)
)
BEGIN
    INSERT INTO customer(
        first_name,
        last_name,
        national_id,
        mobile_phone
    )
    VALUES(
        p_first_name,
        p_last_name,
        p_national_id,
        p_mobile_phone
    );
END //

-- =====================================================
-- 7. Show 5-star hotels
-- =====================================================

CREATE PROCEDURE GetFiveStarHotels()
BEGIN
    SELECT name,
           address,
           phone_number,
           star_rating
    FROM hotel
    WHERE star_rating = 5;
END //

-- =====================================================
-- 8. Count gold customers
-- =====================================================

CREATE PROCEDURE CountGoldCustomers()
BEGIN
    SELECT COUNT(*) AS gold_members
    FROM customer
    WHERE membership_level = 'gold';
END //

DELIMITER ;