from django.db import models
from facility_admin.models import Room
from member_access.models import Member

class Instructor(models.Model):
    InstructorID = models.AutoField(primary_key=True)
    FirstName = models.CharField(max_length=100)
    LastName = models.CharField(max_length=100)
    Specialization = models.CharField(max_length=100)
    Email = models.EmailField(unique=True)
    HireDate = models.DateField()
    Phone = models.CharField(max_length=20)
    Status = models.CharField(max_length=20, default='Active')
    AvailabilityNote = models.TextField(null=True, blank=True)

    def __str__(self):
        return f"{self.FirstName} {self.LastName} - {self.Specialization}"

class InstructorShift(models.Model):
    ShiftID = models.AutoField(primary_key=True)
    InstructorID = models.ForeignKey(Instructor, on_delete=models.CASCADE)
    ShiftDate = models.DateField()
    StartTime = models.TimeField()
    EndTime = models.TimeField()

    def __str__(self):
        return f"{self.InstructorID.FirstName} Shift: {self.ShiftDate}"

class Class(models.Model):
    ClassID = models.AutoField(primary_key=True)
    ClassName = models.CharField(max_length=100)
    ClassType = models.CharField(max_length=50)
    MaxCapacity = models.IntegerField()
    RoomID = models.ForeignKey(Room, on_delete=models.SET_NULL, null=True)
    DifficultyLevel = models.CharField(max_length=50)
    DurationMinutes = models.IntegerField()

    def __str__(self):
        return self.ClassName

class ClassSchedule(models.Model):
    ScheduleID = models.AutoField(primary_key=True)
    ClassID = models.ForeignKey(Class, on_delete=models.CASCADE)
    InstructorID = models.ForeignKey(Instructor, on_delete=models.SET_NULL, null=True)
    DayOfWeek = models.CharField(max_length=20)
    StartTime = models.TimeField()
    EndTime = models.TimeField()

    def __str__(self):
        return f"{self.ClassID.ClassName} on {self.DayOfWeek}"

class Enrollment(models.Model):
    EnrollmentID = models.AutoField(primary_key=True)
    MemberID = models.ForeignKey(Member, on_delete=models.CASCADE)
    ScheduleID = models.ForeignKey(ClassSchedule, on_delete=models.CASCADE)
    EnrollmentDate = models.DateField(auto_now_add=True)
    AttendanceStatus = models.CharField(max_length=20)

    def __str__(self):
        return f"{self.MemberID.FirstName} in {self.ScheduleID.ClassID.ClassName}"
