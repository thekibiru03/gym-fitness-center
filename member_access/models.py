from django.db import models

class Membership(models.Model):
    MembershipID = models.AutoField(primary_key=True)
    Type = models.CharField(max_length=50)
    MonthlyFee = models.DecimalField(max_digits=10, decimal_places=2)
    AccessLevel = models.CharField(max_length=50)
    DurationMonths = models.IntegerField()

    def __str__(self):
        return f"{self.Type} - ${self.MonthlyFee}/mo"


class Member(models.Model):
    MemberID = models.AutoField(primary_key=True)
    FirstName = models.CharField(max_length=100)
    LastName = models.CharField(max_length=100)
    Email = models.EmailField(unique=True)
    Phone = models.CharField(max_length=20)
    DateJoined = models.DateField(auto_now_add=True)
    MembershipID = models.ForeignKey(Membership, on_delete=models.SET_NULL, null=True)
    Gender = models.CharField(max_length=20, null=True, blank=True)
    EmergencyContactName = models.CharField(max_length=150)
    EmergencyContactPhone = models.CharField(max_length=20)

    def __str__(self):
        return f"{self.FirstName} {self.LastName}"
