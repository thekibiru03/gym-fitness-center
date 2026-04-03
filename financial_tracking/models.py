from django.db import models
from member_access.models import Member

class Payment(models.Model):
    PaymentID = models.AutoField(primary_key=True)
    MemberID = models.ForeignKey(Member, on_delete=models.CASCADE)
    Amount = models.DecimalField(max_digits=10, decimal_places=2)
    PaymentDate = models.DateTimeField(auto_now_add=True)
    PaymentMethod = models.CharField(max_length=50)
    Status = models.CharField(max_length=20)
    TransactionReference = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return f"Payment {self.PaymentID} - {self.MemberID.FirstName} - ${self.Amount}"
