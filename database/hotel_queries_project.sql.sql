USE hotelmanagementsystem;

-- =====================================================
-- Hotel Management System - Queries
-- =====================================================

-- 1. Show all empty rooms (for reception desk)
-- Operational query - find available rooms for new guests
SELECT room_number, floor_number, standard_price_per_night
FROM room
WHERE status = 'empty';

-- 2. Count how many customers have gold membership
-- Reporting query - count gold members for marketing
SELECT COUNT(*)
FROM customer
WHERE membership_level = 'gold';

-- 3. Show all 5-star hotels
-- Reporting query - list luxury hotels for customers
SELECT name, address, phone_number, star_rating
FROM hotel
WHERE star_rating = 5;

-- 4. Show unpaid invoices (for accounting)
-- Operational query - find customers who still owe money
SELECT invoice_number, grand_total, remaining_amount
FROM invoice
WHERE status = 'unsettled';

-- 5. Show total revenue from all hotels
-- Reporting query - calculate total money earned
SELECT SUM(grand_total)
FROM invoice
WHERE status = 'settled';

-- 6. Show reservations for next 7 days (for front desk)
-- Operational query - see upcoming guest arrivals
SELECT reservation_number, check_in_date, check_out_date
FROM reservation
WHERE check_in_date >= CURDATE()
AND check_in_date <= CURDATE() + 7
AND status = 'confirmed';

-- 7. Show each customer's total nights stayed
-- Reporting query - find loyal customers
SELECT first_name, last_name, total_stays
FROM customer
ORDER BY total_stays DESC;

-- 8. Show rooms that are occupied right now
-- Operational query - know which rooms are currently taken
SELECT room_number, floor_number
FROM room
WHERE status = 'occupied';

-- 9. Show average price per room type
-- Reporting query - compare prices between room categories
SELECT room_type_id, AVG(standard_price_per_night)
FROM room
GROUP BY room_type_id;

-- 10. Show all staff who work at a specific hotel
-- Operational query - see employee list for a hotel
SELECT first_name, last_name, job_title
FROM staff
WHERE hotel_id = 1;