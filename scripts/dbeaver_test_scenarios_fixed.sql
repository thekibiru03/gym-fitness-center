-- Phase III: DBeaver Test Scenarios
-- Gym & Fitness Center Management System
-- NOTE: All column names are quoted CamelCase to match the create_tables.sql definitions.
-- Django uses quoted CamelCase columns, so unquoted lowercase names will fail in PostgreSQL.
-- ==========================================


-- ==========================================
-- POSITIVE SCENARIOS
-- ==========================================

-- 1. Facility Setup (Room & Equipment)
-- Action: Insert a Room, then insert Equipment linked to that room.
INSERT INTO facility_admin_room ("RoomName", "Type", "Floor", "Capacity")
VALUES ('Main Weight Room', 'Weight Room', 1, 50);

-- NOTE: If this is not the first room inserted, check the generated RoomID
-- by running: SELECT * FROM facility_admin_room;
-- Then update the "RoomID_id" value below to match.
INSERT INTO facility_admin_equipment ("Name", "Category", "RoomID_id", "PurchaseDate", "Condition")
VALUES ('Squat Rack A', 'Strength', 1, '2023-01-15', 'Good');

-- Validation: Confirm equipment record exists
SELECT * FROM facility_admin_equipment;


-- 2. New Member Registration
-- Action: Insert a Membership tier, then insert a Member linked to that tier.
INSERT INTO member_access_membership ("Type", "MonthlyFee", "AccessLevel", "DurationMonths")
VALUES ('Gold Tier', 75.00, 'All Access', 12);

-- NOTE: If this is not the first membership inserted, check the generated MembershipID
-- by running: SELECT * FROM member_access_membership;
-- Then update the "MembershipID_id" value below to match.
INSERT INTO member_access_member (
    "FirstName", "LastName", "Email", "Phone",
    "Gender", "DateJoined", "MembershipID_id",
    "EmergencyContactName", "EmergencyContactPhone"
)
VALUES (
    'Sarah', 'Connor', 'sconnor@example.com', '555-123-4567',
    'Female', CURRENT_DATE, 1,
    'John Connor', '555-987-6543'
);

-- Validation: JOIN Member and Membership to confirm the link
SELECT
    m."FirstName",
    m."LastName",
    m."Email",
    ms."Type",
    ms."MonthlyFee"
FROM member_access_member m
INNER JOIN member_access_membership ms ON m."MembershipID_id" = ms."MembershipID";


-- 3. HR Management (Instructor Hiring & Status Update)
-- Action: Insert a new instructor, then simulate a resignation by setting status to Inactive.
INSERT INTO class_ops_instructor (
    "FirstName", "LastName", "Email", "Phone",
    "Specialization", "HireDate", "Status", "AvailabilityNote"
)
VALUES (
    'Bruce', 'Wayne', 'bwayne@gym.com', '555-000-0000',
    'Martial Arts', CURRENT_DATE, 'Active', 'Available evenings'
);

-- Action: Simulate resignation
UPDATE class_ops_instructor
SET "Status" = 'Inactive'
WHERE "Email" = 'bwayne@gym.com';

-- Validation: Confirm status has changed
SELECT "FirstName", "LastName", "Status"
FROM class_ops_instructor
WHERE "Email" = 'bwayne@gym.com';


-- 4. Member Class Enrollment
-- Action: Create a Class, then a Schedule, then enroll a Member.

-- Step 1: Insert a Class
INSERT INTO class_ops_class (
    "ClassName", "ClassType", "MaxCapacity",
    "RoomID_id", "DifficultyLevel", "DurationMinutes"
)
VALUES ('Evening HIIT', 'Cardio', 20, 1, 'Hard', 45);

-- Step 2: Insert a Schedule linking the Class and Instructor
-- NOTE: Check generated ClassID and InstructorID if needed before running this.
INSERT INTO class_ops_classschedule (
    "ClassID_id", "InstructorID_id", "DayOfWeek", "StartTime", "EndTime"
)
VALUES (1, 1, 'Wednesday', '18:00:00', '18:45:00');

-- Step 3: Enroll the Member into the Schedule
-- NOTE: Check generated MemberID and ScheduleID if needed before running this.
INSERT INTO class_ops_enrollment (
    "MemberID_id", "ScheduleID_id", "EnrollmentDate", "AttendanceStatus"
)
VALUES (1, 1, CURRENT_DATE, 'Enrolled');

-- Validation: Confirm enrollment record exists
SELECT * FROM class_ops_enrollment WHERE "MemberID_id" = 1;


-- 5. Facility Auditing (Equipment Condition Update)
-- Action: Update the condition of a piece of equipment to reflect a maintenance issue.
UPDATE facility_admin_equipment
SET "Condition" = 'Needs Maintenance'
WHERE "Name" = 'Squat Rack A';

-- Validation: Confirm the condition was updated
SELECT "Name", "Condition"
FROM facility_admin_equipment
WHERE "Name" = 'Squat Rack A';


-- 6. Financial Logging & Reporting
-- Action: Insert a Payment record, then run a summary query for today's revenue.
INSERT INTO financial_tracking_payment (
    "MemberID_id", "Amount", "PaymentDate",
    "PaymentMethod", "Status", "TransactionReference"
)
VALUES (1, 75.00, CURRENT_TIMESTAMP, 'Credit Card', 'Completed', 'TXN-100200300');

-- Validation: Total revenue collected today
SELECT SUM("Amount") AS total_daily_revenue
FROM financial_tracking_payment
WHERE DATE("PaymentDate") = CURRENT_DATE;


-- ==========================================
-- NEGATIVE SCENARIOS (Data Integrity Tests)
-- Run each statement below and screenshot the DBeaver error popup.
-- ==========================================

-- 7. Duplicate Member Prevention (UNIQUE Constraint)
-- Action: Attempt to insert a member using an email that already exists in the database.
-- Expected error: duplicate key value violates unique constraint on "Email"
INSERT INTO member_access_member (
    "FirstName", "LastName", "Email", "Phone",
    "DateJoined", "MembershipID_id",
    "EmergencyContactName", "EmergencyContactPhone"
)
VALUES (
    'Fake', 'Sarah', 'sconnor@example.com', '555-999-8888',
    CURRENT_DATE, 1,
    'Nobody', '000-000-0000'
);


-- 8. Ghost Enrollment Prevention (FOREIGN KEY Constraint)
-- Action: Attempt to enroll a member into a ScheduleID that does not exist (999999).
-- Expected error: insert or update on table violates foreign key constraint
INSERT INTO class_ops_enrollment (
    "MemberID_id", "ScheduleID_id", "EnrollmentDate", "AttendanceStatus"
)
VALUES (1, 999999, CURRENT_DATE, 'Enrolled');
