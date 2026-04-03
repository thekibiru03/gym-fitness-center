-- Gym & Fitness Center Management System Phase III
-- PostgreSQL Table Creation Script

CREATE TABLE member_access_membership (
    "MembershipID" serial NOT NULL PRIMARY KEY,
    "Type" varchar(50) NOT NULL,
    "MonthlyFee" numeric(10, 2) NOT NULL,
    "AccessLevel" varchar(50) NOT NULL,
    "DurationMonths" integer NOT NULL
);

CREATE TABLE member_access_member (
    "MemberID" serial NOT NULL PRIMARY KEY,
    "FirstName" varchar(100) NOT NULL,
    "LastName" varchar(100) NOT NULL,
    "Email" varchar(254) NOT NULL UNIQUE,
    "Phone" varchar(20) NOT NULL,
    "DateJoined" date NOT NULL,
    "MembershipID_id" integer NULL REFERENCES member_access_membership ("MembershipID") DEFERRABLE INITIALLY DEFERRED,
    "Gender" varchar(20) NULL,
    "EmergencyContactName" varchar(150) NOT NULL,
    "EmergencyContactPhone" varchar(20) NOT NULL
);

CREATE TABLE facility_admin_room (
    "RoomID" serial NOT NULL PRIMARY KEY,
    "RoomName" varchar(100) NOT NULL,
    "Type" varchar(50) NOT NULL,
    "Floor" integer NOT NULL,
    "Capacity" integer NOT NULL
);

CREATE TABLE facility_admin_equipment (
    "EquipmentID" serial NOT NULL PRIMARY KEY,
    "Name" varchar(100) NOT NULL,
    "Category" varchar(50) NOT NULL,
    "RoomID_id" integer NULL REFERENCES facility_admin_room ("RoomID") DEFERRABLE INITIALLY DEFERRED,
    "PurchaseDate" date NOT NULL,
    "Condition" varchar(50) NOT NULL,
    "LastServiced" date NULL
);

CREATE TABLE class_ops_instructor (
    "InstructorID" serial NOT NULL PRIMARY KEY,
    "FirstName" varchar(100) NOT NULL,
    "LastName" varchar(100) NOT NULL,
    "Specialization" varchar(100) NOT NULL,
    "Email" varchar(254) NOT NULL UNIQUE,
    "HireDate" date NOT NULL,
    "Phone" varchar(20) NOT NULL,
    "Status" varchar(20) NOT NULL,
    "AvailabilityNote" text NULL
);

CREATE TABLE class_ops_instructorshift (
    "ShiftID" serial NOT NULL PRIMARY KEY,
    "InstructorID_id" integer NOT NULL REFERENCES class_ops_instructor ("InstructorID") DEFERRABLE INITIALLY DEFERRED,
    "ShiftDate" date NOT NULL,
    "StartTime" time NOT NULL,
    "EndTime" time NOT NULL
);

CREATE TABLE class_ops_class (
    "ClassID" serial NOT NULL PRIMARY KEY,
    "ClassName" varchar(100) NOT NULL,
    "ClassType" varchar(50) NOT NULL,
    "MaxCapacity" integer NOT NULL,
    "RoomID_id" integer NULL REFERENCES facility_admin_room ("RoomID") DEFERRABLE INITIALLY DEFERRED,
    "DifficultyLevel" varchar(50) NOT NULL,
    "DurationMinutes" integer NOT NULL
);

CREATE TABLE class_ops_classschedule (
    "ScheduleID" serial NOT NULL PRIMARY KEY,
    "ClassID_id" integer NOT NULL REFERENCES class_ops_class ("ClassID") DEFERRABLE INITIALLY DEFERRED,
    "InstructorID_id" integer NULL REFERENCES class_ops_instructor ("InstructorID") DEFERRABLE INITIALLY DEFERRED,
    "DayOfWeek" varchar(20) NOT NULL,
    "StartTime" time NOT NULL,
    "EndTime" time NOT NULL
);

CREATE TABLE class_ops_enrollment (
    "EnrollmentID" serial NOT NULL PRIMARY KEY,
    "MemberID_id" integer NOT NULL REFERENCES member_access_member ("MemberID") DEFERRABLE INITIALLY DEFERRED,
    "ScheduleID_id" integer NOT NULL REFERENCES class_ops_classschedule ("ScheduleID") DEFERRABLE INITIALLY DEFERRED,
    "EnrollmentDate" date NOT NULL,
    "AttendanceStatus" varchar(20) NOT NULL
);

CREATE TABLE financial_tracking_payment (
    "PaymentID" serial NOT NULL PRIMARY KEY,
    "MemberID_id" integer NOT NULL REFERENCES member_access_member ("MemberID") DEFERRABLE INITIALLY DEFERRED,
    "Amount" numeric(10, 2) NOT NULL,
    "PaymentDate" timestamp with time zone NOT NULL,
    "PaymentMethod" varchar(50) NOT NULL,
    "Status" varchar(20) NOT NULL,
    "TransactionReference" varchar(100) NULL
);
