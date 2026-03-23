from django.urls import path

from . import views

app_name = "class_ops"

urlpatterns = [
    path("create/", views.create_class, name="create_class"),
    path("trainers/", views.manage_trainers, name="manage_trainers"),
    path("assign-trainer/", views.assign_trainer, name="assign_trainer"),
    path("enroll/", views.enroll_member, name="enroll_member"),
    path("daily-schedule/", views.daily_schedule, name="daily_schedule"),
]
