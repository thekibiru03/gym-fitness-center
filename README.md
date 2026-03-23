# Gym & Fitness Center Management System (Django UI Phase)

This project is a Django-based admin tool for managing day-to-day gym operations.

Current status: **UI-first implementation with hardcoded data** (no business logic/database models wired yet for domain entities).

## Tech Stack

- Python 3
- Django 5
- SQLite (default Django database, currently only Django built-in tables migrated)
- Django Template Language (MVT)
- Custom CSS

## Project Structure

- `gym_system/` - Django project config (`settings.py`, main `urls.py`)
- `member_access/` - member registration, check-in, renewal pages
- `class_ops/` - class creation, trainer management/assignment, enrollment, schedule report pages
- `facility_admin/` - equipment condition page
- `financial_tracking/` - app scaffolded for future payment domain logic
- `templates/` - shared and page templates
- `static/css/styles.css` - custom styling

## Implemented Pages

All pages below are implemented as templates and routes with static/hardcoded UI data:

1. Register New Member
2. Member Check-In
3. Process Membership Renewal
4. Create a Fitness Class
5. Manage Trainers
6. Assign Trainer to Class
7. Enroll Member into Class
8. Update Equipment Condition
9. Daily Schedule Report

## Routes

- `/` - Register Member
- `/check-in/` - Member Check-In
- `/membership-renewal/` - Membership Renewal
- `/classes/create/` - Create Class
- `/classes/trainers/` - Manage Trainers
- `/classes/assign-trainer/` - Assign Trainer
- `/classes/enroll/` - Enroll Member
- `/facility/equipment/` - Update Equipment
- `/classes/daily-schedule/` - Daily Schedule Report

## Wireframes

### Register Member
![Register Member](docs/wireframes/01-register-member.png)

### Member Check-In
![Member Check-In](docs/wireframes/02-member-checkin.png)

### Membership Renewal
![Membership Renewal](docs/wireframes/03-membership-renewal.png)

### Create Class
![Create Class](docs/wireframes/04-create-class.png)

### Assign Trainer
![Assign Trainer](docs/wireframes/05-assign-trainer.png)

### Enroll Member
![Enroll Member](docs/wireframes/06-enroll-member.png)

### Update Equipment
![Update Equipment](docs/wireframes/07-update-equipment.png)

### Daily Schedule
![Daily Schedule](docs/wireframes/08-daily-schedule.png)

### Manage Trainers
![Manage Trainers](docs/wireframes/09-manage-trainers.png)

## Setup and Run

From the project root:

```bash
python3 -m pip install django
python3 manage.py migrate
python3 manage.py runserver
```

Open:

- [http://127.0.0.1:8000](http://127.0.0.1:8000)

## Current Scope (Important)

- Sidebar navigation is static.
- Forms are UI-only and do not save domain data yet.
- Member/class/trainer/equipment/report data shown in pages is hardcoded in views.
- Authentication/login is intentionally deferred to a later phase.

## Next Phase Suggestions

- Add domain models and migrations for:
  - members, memberships, check-ins
  - classes, schedules, instructors, instructor shifts, enrollments
  - rooms, equipment
  - payments
- Replace hardcoded view data with database queries.
- Add form handling with validation and success/error messages.
- Add login/auth and role-based access for admin users.
- Add CSV export backend for the daily schedule report.
