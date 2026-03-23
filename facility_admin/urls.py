from django.urls import path

from . import views

app_name = "facility_admin"

urlpatterns = [
    path("equipment/", views.update_equipment, name="update_equipment"),
]
