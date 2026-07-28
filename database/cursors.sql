USE hotelmanagementsystem;

DELIMITER //

-- =====================================================
-- 1. Show gold customers one by one
-- =====================================================

CREATE PROCEDURE ShowGoldCustomers()
BEGIN

    DECLARE finished INT DEFAULT 0;

    DECLARE fname VARCHAR(50);
    DECLARE lname VARCHAR(50);

    DECLARE customer_cursor CURSOR FOR
        SELECT first_name, last_name
        FROM customer
        WHERE membership_level = 'gold';

    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET finished = 1;

    OPEN customer_cursor;

    customer_loop: LOOP

        FETCH customer_cursor
        INTO fname, lname;

        IF finished = 1 THEN
            LEAVE customer_loop;
        END IF;

        SELECT CONCAT(fname, ' ', lname)
        AS gold_customer;

    END LOOP;

    CLOSE customer_cursor;

END //

-- =====================================================
-- 2. Calculate total unsettled invoice amount
-- =====================================================

CREATE PROCEDURE CalculateUnsettledInvoices()
BEGIN

    DECLARE finished INT DEFAULT 0;

    DECLARE amount DECIMAL(10,2);

    DECLARE total DECIMAL(10,2) DEFAULT 0;

    DECLARE invoice_cursor CURSOR FOR
        SELECT remaining_amount
        FROM invoice
        WHERE status = 'unsettled';

    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET finished = 1;

    OPEN invoice_cursor;

    invoice_loop: LOOP

        FETCH invoice_cursor INTO amount;

        IF finished = 1 THEN
            LEAVE invoice_loop;
        END IF;

        SET total = total + amount;

    END LOOP;

    CLOSE invoice_cursor;

    SELECT total AS total_unsettled_amount;

END //

-- =====================================================
-- 3. Increase room prices in 5-star hotels
-- =====================================================

CREATE PROCEDURE IncreaseLuxuryRoomPrices()
BEGIN

    DECLARE finished INT DEFAULT 0;

    DECLARE r_id INT;

    DECLARE luxury_cursor CURSOR FOR
        SELECT room.room_id
        FROM room
        JOIN hotel
        ON room.hotel_id = hotel.hotel_id
        WHERE hotel.star_rating = 5;

    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET finished = 1;

    OPEN luxury_cursor;

    update_loop: LOOP

        FETCH luxury_cursor INTO r_id;

        IF finished = 1 THEN
            LEAVE update_loop;
        END IF;

        UPDATE room
        SET standard_price_per_night =
            standard_price_per_night * 1.10
        WHERE room_id = r_id;

    END LOOP;

    CLOSE luxury_cursor;

END //

-- =====================================================
-- 4. Show occupied rooms one by one
-- =====================================================

CREATE PROCEDURE ShowOccupiedRooms()
BEGIN

    DECLARE finished INT DEFAULT 0;

    DECLARE room_num VARCHAR(10);

    DECLARE occupied_cursor CURSOR FOR
        SELECT room_number
        FROM room
        WHERE status = 'occupied';

    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET finished = 1;

    OPEN occupied_cursor;

    occupied_loop: LOOP

        FETCH occupied_cursor INTO room_num;

        IF finished = 1 THEN
            LEAVE occupied_loop;
        END IF;

        SELECT room_num AS occupied_room;

    END LOOP;

    CLOSE occupied_cursor;

END //

DELIMITER ;