/* =====================================================
   HOTEL MANAGEMENT SYSTEM - SECURITY TRIGGERS (FIXED VERSION)
   Uses users table instead of @current_role
===================================================== */

DELIMITER $$

/* =====================================================
   1. RESERVATION UPDATE SECURITY
===================================================== */
CREATE TRIGGER trg_reservation_update_security
BEFORE UPDATE ON reservation
FOR EACH ROW
BEGIN
    DECLARE v_role VARCHAR(20);

    SELECT role INTO v_role
    FROM users
    WHERE username = @current_username
    LIMIT 1;

    IF v_role NOT IN ('admin', 'reception') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Cannot update reservation';
    END IF;
END$$


/* =====================================================
   2. RESERVATION DELETE SECURITY
===================================================== */
CREATE TRIGGER trg_reservation_delete_security
BEFORE DELETE ON reservation
FOR EACH ROW
BEGIN
    DECLARE v_role VARCHAR(20);

    SELECT role INTO v_role
    FROM users
    WHERE username = @current_username
    LIMIT 1;

    IF v_role <> 'admin' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Only admin can delete reservation';
    END IF;
END$$


/* =====================================================
   3. RESERVATION INSERT SECURITY
===================================================== */
CREATE TRIGGER trg_reservation_insert_security
BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN
    DECLARE v_role VARCHAR(20);

    SELECT role INTO v_role
    FROM users
    WHERE username = @current_username
    LIMIT 1;

    IF v_role = 'housekeeping' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Housekeeping cannot create reservation';
    END IF;
END$$


/* =====================================================
   4. INVOICE UPDATE SECURITY
===================================================== */
CREATE TRIGGER trg_invoice_update_security
BEFORE UPDATE ON invoice
FOR EACH ROW
BEGIN
    DECLARE v_role VARCHAR(20);

    SELECT role INTO v_role
    FROM users
    WHERE username = @current_username
    LIMIT 1;

    IF v_role NOT IN ('admin', 'cashier') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Only cashier or admin can modify invoice';
    END IF;
END$$


/* =====================================================
   5. PAYMENT INSERT SECURITY
===================================================== */
CREATE TRIGGER trg_payment_insert_security
BEFORE INSERT ON payment
FOR EACH ROW
BEGIN
    DECLARE v_role VARCHAR(20);

    SELECT role INTO v_role
    FROM users
    WHERE username = @current_username
    LIMIT 1;

    IF v_role NOT IN ('admin', 'cashier') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Only cashier can insert payment';
    END IF;
END$$


/* =====================================================
   6. STAFF UPDATE SECURITY
===================================================== */
CREATE TRIGGER trg_staff_update_security
BEFORE UPDATE ON staff
FOR EACH ROW
BEGIN
    DECLARE v_role VARCHAR(20);

    SELECT role INTO v_role
    FROM users
    WHERE username = @current_username
    LIMIT 1;

    IF v_role <> 'admin' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Only admin can modify staff';
    END IF;
END$$


/* =====================================================
   7. HOUSEKEEPING BLOCK RESERVATION INSERT
===================================================== */
CREATE TRIGGER trg_housekeeping_block_reservation
BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN
    DECLARE v_role VARCHAR(20);

    SELECT role INTO v_role
    FROM users
    WHERE username = @current_username
    LIMIT 1;

    IF v_role = 'housekeeping' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Housekeeping cannot create reservation';
    END IF;
END$$


/* =====================================================
   8. AUDIT LOG (OPTIONAL BUT RECOMMENDED)
===================================================== */
CREATE TRIGGER trg_reservation_audit
AFTER UPDATE ON reservation
FOR EACH ROW
BEGIN
    DECLARE v_role VARCHAR(20);

    SELECT role INTO v_role
    FROM users
    WHERE username = @current_username
    LIMIT 1;

    INSERT INTO audit_log(table_name, action_type, user_role, message)
    VALUES (
        'reservation',
        'UPDATE',
        v_role,
        CONCAT('Reservation ', OLD.reservation_id, ' updated')
    );
END$$

DELIMITER ;