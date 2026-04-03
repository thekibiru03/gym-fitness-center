# Phase III: Gym & Fitness Center Management System Report

## 1. Summary of Design Changes (Phase I & II vs Phase III)
- **Constraint Solidification:** Added specific relational bounds (like `SET_NULL` vs `CASCADE`) in the ORM schema that weren't strictly defined in early mockups.
- **Normalization:** Enforced proper decoupling in `Instructor` and `InstructorShift` to allow trainers to hold multiple shifts easily without duplicating their core credentials.
- **Data Definition Scaling:** Upgraded properties like `DurationMinutes` to strictly `integer` and normalized `Amount` fields dynamically to `numeric(10, 2)` to adhere accurately to PostreSQL definitions compared to the initial Phase I design which assumed floats.
- **Environment Isolation:** Implemented `python-decouple` configurations to strictly handle standard settings out of code versioning, migrating away from SQLite.

---

## 2. Implementation Challenges & Learning Curve

During the transition from Phase I & II to the actual database structure in Phase III, our team encountered and overcame several key hurdles:

*   **Migrating from SQLite to PostgreSQL:** Our lectures primarily showcased SQLite for Django development. Upgrading to an enterprise-level PostgreSQL database introduced strict data-type checking and a more complex setup process. We had to ensure our data dictionary translated perfectly to PostgreSQL constraints, which behave differently than SQLite.
*   **Docker Infrastructure & Environment Variables:** Setting up the PostgreSQL database required hosting it as a Docker container. The learning curve of mapping Docker ports, handling remote IPs, and ensuring our Django credentials securely mapped to the database using a `.env` file was significant but resulted in a highly robust application.

---

## 3. Data Dictionary

| Table | Field | Data Type | Constraint | Reference |
|---|---|---|---|---|
| **Membership** | MembershipID | serial | PRIMARY KEY, NOT NULL | |
| | Type | varchar(50) | NOT NULL | |
| | MonthlyFee | numeric(10,2) | NOT NULL | |
| | AccessLevel | varchar(50) | NOT NULL | |
| | DurationMonths | integer | NOT NULL | |
| **Member** | MemberID | serial | PRIMARY KEY, NOT NULL | |
| | FirstName | varchar(100) | NOT NULL | |
| | LastName | varchar(100) | NOT NULL | |
| | Email | varchar(254) | UNIQUE, NOT NULL | |
| | Phone | varchar(20) | NOT NULL | |
| | DateJoined | date | NOT NULL | |
| | MembershipID_id | integer | FOREIGN KEY, NULL | `Membership(MembershipID)` |
| | Gender | varchar(20) | NULL | |
| | EmergencyContactName | varchar(150) | NOT NULL | |
| | EmergencyContactPhone | varchar(20) | NOT NULL | |
| **Room** | RoomID | serial | PRIMARY KEY, NOT NULL | |
| | RoomName | varchar(100) | NOT NULL | |
| | Type | varchar(50) | NOT NULL | |
| | Floor | integer | NOT NULL | |
| | Capacity | integer | NOT NULL | |
| **Equipment** | EquipmentID | serial | PRIMARY KEY, NOT NULL | |
| | Name | varchar(100) | NOT NULL | |
| | Category | varchar(50) | NOT NULL | |
| | RoomID_id | integer | FOREIGN KEY, NULL | `Room(RoomID)` |
| | PurchaseDate | date | NOT NULL | |
| | Condition | varchar(50) | NOT NULL | |
| | LastServiced | date | NULL | |
| **Instructor** | InstructorID | serial | PRIMARY KEY, NOT NULL | |
| | FirstName | varchar(100) | NOT NULL | |
| | LastName | varchar(100) | NOT NULL | |
| | Specialization | varchar(100) | NOT NULL | |
| | Email | varchar(254) | UNIQUE, NOT NULL | |
| | HireDate | date | NOT NULL | |
| | Phone | varchar(20) | NOT NULL | |
| | Status | varchar(20) | NOT NULL | |
| | AvailabilityNote | text | NULL | |
| **InstructorShift** | ShiftID | serial | PRIMARY KEY, NOT NULL | |
| | InstructorID_id | integer | FOREIGN KEY, NOT NULL | `Instructor(InstructorID)`|
| | ShiftDate | date | NOT NULL | |
| | StartTime | time | NOT NULL | |
| | EndTime | time | NOT NULL | |
| **Class** | ClassID | serial | PRIMARY KEY, NOT NULL | |
| | ClassName | varchar(100) | NOT NULL | |
| | ClassType | varchar(50) | NOT NULL | |
| | MaxCapacity | integer | NOT NULL | |
| | RoomID_id | integer | FOREIGN KEY, NULL | `Room(RoomID)` |
| | DifficultyLevel | varchar(50) | NOT NULL | |
| | DurationMinutes | integer | NOT NULL | |
| **ClassSchedule** | ScheduleID | serial | PRIMARY KEY, NOT NULL | |
| | ClassID_id | integer | FOREIGN KEY, NOT NULL | `Class(ClassID)` |
| | InstructorID_id | integer | FOREIGN KEY, NULL | `Instructor(InstructorID)`|
| | DayOfWeek | varchar(20) | NOT NULL | |
| | StartTime | time | NOT NULL | |
| | EndTime | time | NOT NULL | |
| **Enrollment** | EnrollmentID | serial | PRIMARY KEY, NOT NULL | |
| | MemberID_id | integer | FOREIGN KEY, NOT NULL | `Member(MemberID)` |
| | ScheduleID_id | integer | FOREIGN KEY, NOT NULL | `ClassSchedule(ScheduleID)`|
| | EnrollmentDate | date | NOT NULL | |
| | AttendanceStatus | varchar(20) | NOT NULL | |
| **Payment** | PaymentID | serial | PRIMARY KEY, NOT NULL | |
| | MemberID_id | integer | FOREIGN KEY, NOT NULL | `Member(MemberID)` |
| | Amount | numeric(10,2) | NOT NULL | |
| | PaymentDate | date | NOT NULL | |
| | PaymentMethod | varchar(50) | NOT NULL | |
| | Status | varchar(20) | NOT NULL | |
| | TransactionReference | varchar(100)| NULL | |

---

## 4. Database Tables mapped to Use-Cases

1. **Member & Membership**: Aligned predominantly with **UC1 (Register a New Member)**, **UC2 (Member Check-In)**, and **UC3 (Process Membership Renewal)**.
2. **Room**: Used extensively in **UC4 (Create a Fitness Class)** layout plotting and constraint rules safely.
3. **Equipment**: Supports **UC7 (Update Equipment Condition)** directly bridging to individual room relations.
4. **Instructor & InstructorShift**: Resolves operations under **UC9 (Manage Trainers)** providing HR records and detailed shift mapping logically separated.
5. **Class & ClassSchedule**: Aligned intricately with **UC4 (Create a Fitness Class)** and **UC5 (Assign a Trainer to a Class)** linking Room, Instructor, and capacities together.
6. **Enrollment**: Manages **UC6 (Enroll a Member into a Class)** enforcing references securely to verify capacity and existing schedules.
7. **Payment**: Underpins **UC3 (Process Membership Renewal)** keeping monetary processing decoupled into tracking domains.

---

## 5. Group Member Contributions

- **Joseph Kibiru**: Member Management & Financials. Architected structures enabling registration pipelines, validated payment constraints, and designed the DBeaver query implementations for Use Cases `UC1`, `UC2`, `UC3`, and `UC8`. Led the Docker & PostgreSQL remote environment configuration.
- **Stephen Remmi**: Class & Instructor Operations. Drafted constraint operations managing complex foreign keys between classes, schedules, and instructors. Validated execution paths and formulated negative testing queries for Use Cases `UC4`, `UC5`, and `UC9`.
- **Mohamud Salah**: Facility & Reporting. Constructed schemas supporting physical capacity rules preventing overallocation in rooms. Authored test scenarios for tracking equipment statuses (`UC6` and `UC7`), and generated the finalized ER diagram in Draw.io.
