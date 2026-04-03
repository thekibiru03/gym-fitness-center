from django.db import models

class Room(models.Model):
    RoomID = models.AutoField(primary_key=True)
    RoomName = models.CharField(max_length=100)
    Type = models.CharField(max_length=50)
    Floor = models.IntegerField()
    Capacity = models.IntegerField()

    def __str__(self):
        return self.RoomName

class Equipment(models.Model):
    EquipmentID = models.AutoField(primary_key=True)
    Name = models.CharField(max_length=100)
    Category = models.CharField(max_length=50)
    RoomID = models.ForeignKey(Room, on_delete=models.SET_NULL, null=True)
    PurchaseDate = models.DateField()
    Condition = models.CharField(max_length=50)
    LastServiced = models.DateField(null=True, blank=True)

    def __str__(self):
        return self.Name
