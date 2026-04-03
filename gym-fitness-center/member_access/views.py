from django.shortcuts import render


def register_member(request):
    context = {
        "page_title": "Register New Member",
    }
    return render(request, "member_access/register_member.html", context)


def member_checkin(request):
    context = {
        "page_title": "Member Check-In",
        "member": {
            "name": "Jane Smith",
            "tier": "Premium",
            "status": "Active",
            "expires": "2025-12-31",
        },
        "recent_checkins": [
            {"date": "2025-03-22", "time": "09:15 AM", "status": "Success"},
            {"date": "2025-03-20", "time": "06:30 PM", "status": "Success"},
            {"date": "2025-03-18", "time": "07:00 AM", "status": "Success"},
        ],
    }
    return render(request, "member_access/member_checkin.html", context)


def membership_renewal(request):
    context = {
        "page_title": "Process Membership Renewal",
        "membership": {
            "tier": "Premium",
            "status": "Expired",
            "expired_on": "2025-01-15",
        },
    }
    return render(request, "member_access/membership_renewal.html", context)
