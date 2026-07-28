CREATE INDEX idx_reservation_dates_hotel ON room(hotel_id, status, room_type_id);
CREATE INDEX idx_room_status ON room(status);
CREATE INDEX idx_invoice_customer_status ON invoice(customer_id, status);
CREATE INDEX idx_reservation_customer_dates ON reservation(customer_id, check_in_date, status);
CREATE INDEX idx_customers_level ON customer(membership_level);
CREATE INDEX idx_payment_reservation ON payment(reservation_id);
CREATE INDEX idx_feedback_status_rating ON feedback(feedback_status, overall_rating);
CREATE INDEX idx_service_reservation ON service(reservation_id);
CREATE INDEX idx_roomtype_price_status ON roomtype(status, min_price_per_night);
