USE hotelmanagementsystem;

DELIMITER //
CREATE PROCEDURE CreateReservationTransaction(
    IN p_reservation_number VARCHAR(20),
    IN p_customer_id INT,
    IN p_room_id INT,
    IN p_check_in DATE,
    IN p_check_out DATE,
    IN p_total DECIMAL(10,2)
)
BEGIN
    START TRANSACTION;
    INSERT INTO reservation(
        reservation_number,
        check_in_date,
        check_out_date,
        status,
        estimated_total,
        room_id,
        customer_id
    )
    VALUES(
        p_reservation_number,
        p_check_in,
        p_check_out,
        'confirmed',
        p_total,
        p_room_id,
        p_customer_id
    );

    UPDATE room
    SET status = 'reserved'
    WHERE room_id = p_room_id;

    INSERT INTO invoice(
        invoice_number,
        grand_total,
        paid_amount,
        remaining_amount,
        status,
        customer_id
    )
    VALUES(
        CONCAT('INV-', p_reservation_number),
        p_total,
        0,
        p_total,
        'unsettled',
        p_customer_id
    );

    COMMIT;
END//

DELIMITER ;


DELIMITER //
CREATE PROCEDURE CancelReservationTransaction(
    IN p_reservation_id INT
)
BEGIN
    DECLARE v_room_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    SELECT room_id
    INTO v_room_id
    FROM reservation
    WHERE reservation_id = p_reservation_id;

    UPDATE reservation
    SET status = 'cancelled'
    WHERE reservation_id = p_reservation_id;

    UPDATE room
    SET status = 'empty'
    WHERE room_id = v_room_id;

    UPDATE invoice
    SET status = 'unsettled'
    WHERE reservation_id = p_reservation_id;

    COMMIT;
END//

DELIMITER ;