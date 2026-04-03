-- Phase III: DBeaver Test Scenarios
-- NOTE: Django automatically prefixes table names with the app name (e.g., member_access_member).
-- ==========================================

-- 1. Facility Setup (Room & Equipment)
-- Action: Insert Room & Equipment
INSERT INTO facility_admin_room (room_name, type, floor, capacity) 
VALUES ('Main Weight Room', 'Weight Room', 1, 50);

-- NOTE: Assuming the room above generated ID 1. If it didn't, change the room_id in the next query.
INSERT INTO facility_admin_equipment (name, category, room_id, purchase_date, condition) 
VALUES ('Squat Rack A', 'Strength', 1, '2023-01-15', 'Good');

-- Validation: Verify existence
SELECT * FROM facility_admin_equipment;


-- 2. New Member Registration
-- Action: Insert Membership tier first
INSERT INTO member_access_membership (type, monthly_fee, access_level, duration_months) 
VALUES ('Gold Tier', 75.00, 'All Access', 12);

-- NOTE: Assuming membership generated ID 1.
INSERT INTO member_access_member (first_name, last_name, email, phone, gender, date_joined, membership_id) 
VALUES ('Sarah', 'Connor', 'sconnor@example.com', '555-123-4567', 'Female', CURRENT_DATE, 1);

-- Validation: Join Member and Membership to prove the link works
SELECT m.first_name, m.last_name, m.email, ms.type, ms.monthly_fee 
FROM member_access_member m
INNER JOIN member_access_membership ms ON m.membership_id = ms.id;


-- 3. HR Management (Instructor Hiring & Status Update)
-- Action: Insert a new instructor
INSERT INTO class_ops_instructor (first_name, last_name, email, phone, specialization, hire_date, status, availability_note) 
VALUES ('Bruce', 'Wayne', 'bwayne@gym.com', '555-000-0000', 'Martial Arts', CURRENT_DATE, 'Active', 'Available evenings');

-- Action: Simulate employee resigning by updating status
UPDATE class_ops_instructor 
SET status = 'Inactive' 
WHERE email = 'bwayne@gym.com';

-- Validation: Show the changed record
SELECT first_name, last_name, status FROM class_ops_instructor WHERE email = 'bwayne@gym.com';


-- 4. Member Class Enrollment
-- NOTE: Let's create a Class and Schedule first.
INSERT INTO class_ops_fitnessclass (class_name, class_type, max_capacity, difficulty_level, duration_minutes, room_id) 
VALUES ('Evening HIIT', 'Cardio', 20, 'Hard', 45, 1);

INSERT INTO class_ops_classschedule (fitness_class_id, instructor_id, day_of_week, start_time, end_time) 
VALUES (1, 1, 'Wednesday', '18:00:00', '18:45:00');

-- Action: Enroll Member (Assuming Member ID 1 and Schedule ID 1 exist now)
INSERT INTO class_ops_enrollment (member_id, schedule_id, enrollment_date, attendance_status) 
VALUES (1, 1, CURRENT_DATE, 'Enrolled');

-- Validation: Show enrollment
SELECT * FROM class_ops_enrollment WHERE member_id = 1;


-- 5. Facility Auditing (Equipment Condition Update)
-- Action: Update equipment condition
UPDATE facility_admin_equipment 
SET condition = 'Needs Maintenance' 
WHERE name = 'Squat Rack A';

-- Validation: Select equipment to see updated condition
SELECT name, condition FROM facility_admin_equipment WHERE name = 'Squat Rack A';


-- 6. Financial Logging & Reporting
-- Action: Insert a Payment Record (Assuming Member ID 1)
INSERT INTO financial_tracking_payment (member_id, amount, payment_date, payment_method, status, transaction_reference) 
VALUES (1, 75.00, CURRENT_DATE, 'Credit Card', 'Completed', 'TXN-100200300');

-- Validation: Show revenue total for today
SELECT SUM(amount) AS total_daily_revenue 
FROM financial_tracking_payment 
WHERE payment_date = CURRENT_DATE;


-- ==========================================
-- VALIDATION (NEGATIVE) SCENARIOS
-- Execute these and screenshot the resulting DBeaver SQL Error Popups!
-- ==========================================

-- 7. Duplicate Member Prevention (UNIQUE Constraint)
-- Action: Attempt to insert another member with the exact same email 'sconnor@example.com'
-- Validation: Should throw "duplicate key value violates unique constraint"
INSERT INTO member_access_member (first_name, last_name, email, phone, date_joined, membership_id) 
VALUES ('Fake', 'Sarah', 'sconnor@example.com', '555-999-8888', CURRENT_DATE, 1);


-- 8. Ghost Enrollment Prevention (FOREIGN KEY Constraint)
-- Action: Attempt to enroll a member into a schedule ID that absolutely does not exist (e.g., 9999)
-- Validation: Should throw "violates foreign key constraint"
INSERT INTO class_ops_enrollment (member_id, schedule_id, enrollment_date, attendance_status) 
VALUES (1, 9999, CURRENT_DATE, 'Enrolled');
