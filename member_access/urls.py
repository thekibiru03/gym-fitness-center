from django.urls import path

from . import views

app_name = "member_access"

urlpatterns = [
    path("", views.register_member, name="register_member"),
    path("check-in/", views.member_checkin, name="member_checkin"),
    path("membership-renewal/", views.membership_renewal, name="membership_renewal"),
]
