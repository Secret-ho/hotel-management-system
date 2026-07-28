DELIMITER //
CREATE FUNCTION CalculateMembershipLevel(stays_count INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE level VARCHAR(20);
	IF stays_count > 20 THEN SET level='gold';
	ELSEIF stays_count >= 10 THEN SET level='silver';
    ELSE SET level='standard';
    END IF;
    RETURN level;
END //

DELIMITER ;

DELIMITER //
CREATE FUNCTION get_discount_percentage(membership_level VARCHAR(20))
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
	DECLARE discount DECIMAL(5,2);
   IF membership_level = 'gold' THEN SET discount = 15.00;
    ELSEIF membership_level = 'silver' THEN SET discount = 10.00;
    ELSEIF membership_level = 'standard' THEN SET discount = 5.00;
    ELSE SET discount = 0.00;
    END IF;
    RETURN discount;
END //

DELIMITER ;


DELIMITER //
CREATE FUNCTION get_hotel_average_rating(hotel_id_param INT,rating_type VARCHAR(20)) 
RETURNS DECIMAL(3,2)
READS SQL DATA
BEGIN
    DECLARE avg_rating DECIMAL(3,2) DEFAULT 0;
    IF rating_type = 'overall' THEN
        SELECT IFNULL(AVG(f.overall_rating), 0)
        INTO avg_rating
        FROM feedback f
        JOIN reservation r ON f.reservation_id = r.reservation_id
        JOIN room rm ON r.room_id = rm.room_id
        WHERE rm.hotel_id = hotel_id_param AND f.feedback_status = 'approved';
    ELSEIF rating_type = 'room' THEN
        SELECT IFNULL(AVG(f.room_quality_rating), 0)
        INTO avg_rating
        FROM feedback f
        JOIN reservation r ON f.reservation_id = r.reservation_id
        JOIN room rm ON r.room_id = rm.room_id
        WHERE rm.hotel_id = hotel_id_param AND f.feedback_status = 'approved';
    ELSEIF rating_type = 'service' THEN
        SELECT IFNULL(AVG(f.service_quality_rating), 0)
        INTO avg_rating
        FROM feedback f
        JOIN reservation r ON f.reservation_id = r.reservation_id
        JOIN room rm ON r.room_id = rm.room_id
        WHERE rm.hotel_id = hotel_id_param AND f.feedback_status = 'approved';
    ELSEIF rating_type = 'staff' THEN
        SELECT IFNULL(AVG(f.staff_behavior_rating), 0)
        INTO avg_rating
        FROM feedback f
        JOIN reservation r ON f.reservation_id = r.reservation_id
        JOIN room rm ON r.room_id = rm.room_id
        WHERE rm.hotel_id = hotel_id_param AND f.feedback_status = 'approved';
    END IF;
    RETURN ROUND(avg_rating, 2);
END//

DELIMITER ;