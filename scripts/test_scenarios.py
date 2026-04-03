import os
import django
from datetime import date, time

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'gym_system.settings')
django.setup()

from member_access.models import Member, Membership
from class_ops.models import Instructor, Class, ClassSchedule, Enrollment
from facility_admin.models import Room

def run_tests():
    print("--- STARTING TEST SCENARIOS ---\n")

    print("[Prerequisites]")
    room, _ = Room.objects.get_or_create(RoomName="Studio 1", Type="Yoga", Floor=1, Capacity=20)
    print(f"Created/Found Room: {room}")
    membership, _ = Membership.objects.get_or_create(Type="Premium", MonthlyFee=50.00, AccessLevel="All", DurationMonths=12)
    print(f"Created/Found Membership: {membership}\n")

    print("--- UC1: Register a New Member ---")
    member, created = Member.objects.get_or_create(
        Email="john.doe@example.com",
        defaults={
            'FirstName': "John", 'LastName': "Doe", 'Phone': "1234567890",
            'MembershipID': membership, 'Gender': "Male",
            'EmergencyContactName': "Jane Doe", 'EmergencyContactPhone': "0987654321"
        }
    )
    if created:
        print(f"Successfully registered new member: {member}")
    else:
        print(f"Member already exists: {member}")
    print("\n")

    print("--- UC9: Manage Trainers ---")
    instructor, created = Instructor.objects.get_or_create(
        Email="jane.smith@example.com",
        defaults={
            'FirstName': "Jane", 'LastName': "Smith", 'Specialization': "Yoga",
            'HireDate': date.today(), 'Phone': "5551234567", 'Status': "Active"
        }
    )
    if created:
        print(f"Successfully added trainer: {instructor}")
    else:
        print(f"Trainer already exists: {instructor}")
    print("\n")

    print("--- UC4: Create a Fitness Class ---")
    fitness_class, created = Class.objects.get_or_create(
        ClassName="Morning Vinyasa",
        defaults={
            'ClassType': "Yoga", 'MaxCapacity': 15, 'RoomID': room,
            'DifficultyLevel': "Beginner", 'DurationMinutes': 60
        }
    )
    if created:
        print(f"Successfully created class: {fitness_class}")
    else:
        print(f"Class already exists: {fitness_class}")
    print("\n")

    print("--- UC5: Assign a Trainer to a Class ---")
    schedule, created = ClassSchedule.objects.get_or_create(
        ClassID=fitness_class,
        DayOfWeek="Monday",
        defaults={
            'InstructorID': instructor,
            'StartTime': time(8, 0), 'EndTime': time(9, 0)
        }
    )
    if created:
        print(f"Successfully assigned trainer to class schedule: {schedule}")
    else:
        print(f"Schedule already exists: {schedule}")
    print("\n")

    print("--- UC6: Enroll a Member into a Class ---")
    enrollment, created = Enrollment.objects.get_or_create(
        MemberID=member,
        ScheduleID=schedule,
        defaults={
            'AttendanceStatus': "Registered"
        }
    )
    if created:
        print(f"Successfully enrolled member into class: {enrollment}")
    else:
        print(f"Enrollment already exists: {enrollment}")
    print("\n")

    print("--- END OF TEST SCENARIOS ---")

if __name__ == "__main__":
    run_tests()
