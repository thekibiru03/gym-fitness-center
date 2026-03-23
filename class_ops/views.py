from django.shortcuts import render


def create_class(request):
    context = {
        "page_title": "Create a Fitness Class",
    }
    return render(request, "class_ops/create_class.html", context)


def manage_trainers(request):
    context = {
        "page_title": "Trainer Management",
        "trainers": [
            {"name": "Sarah Johnson", "specialty": "Yoga", "phone": "(555) 100-1111", "status": "Active"},
            {"name": "Mike Chen", "specialty": "HIIT", "phone": "(555) 100-2222", "status": "Active"},
            {"name": "Lisa Rivera", "specialty": "Spin", "phone": "(555) 100-3333", "status": "Active"},
            {"name": "Amy Torres", "specialty": "Pilates", "phone": "(555) 100-4444", "status": "On Leave"},
        ],
    }
    return render(request, "class_ops/manage_trainers.html", context)


def assign_trainer(request):
    context = {
        "page_title": "Assign Trainer to Class",
        "assignments": [
            {
                "class": "Morning Yoga",
                "day": "Monday",
                "time": "8:00 AM",
                "room": "Room A",
                "instructor": "Sarah Johnson",
            },
            {
                "class": "HIIT Blast",
                "day": "Tuesday",
                "time": "6:00 PM",
                "room": "Room B",
                "instructor": "Mike Chen",
            },
            {
                "class": "Spin Express",
                "day": "Wednesday",
                "time": "7:00 AM",
                "room": "Room C",
                "instructor": "Lisa Rivera",
            },
        ],
    }
    return render(request, "class_ops/assign_trainer.html", context)


def enroll_member(request):
    context = {
        "page_title": "Enroll Member into Class",
        "enrolled": 18,
        "capacity": 25,
    }
    return render(request, "class_ops/enroll_member.html", context)


def daily_schedule(request):
    rows = [
        {"time": "7:00 AM", "class": "Morning Yoga", "type": "Yoga", "instructor": "Sarah Johnson", "room": "Room A", "count": "22/25"},
        {"time": "8:30 AM", "class": "Spin Express", "type": "Spin", "instructor": "Lisa Rivera", "room": "Room C", "count": "18/20"},
        {"time": "10:00 AM", "class": "Strength 101", "type": "Strength", "instructor": "Mike Chen", "room": "Room B", "count": "12/30"},
        {"time": "12:00 PM", "class": "Lunch HIIT", "type": "HIIT", "instructor": "Sarah Johnson", "room": "Room A", "count": "25/25"},
        {"time": "5:30 PM", "class": "Evening Pilates", "type": "Pilates", "instructor": "Amy Torres", "room": "Room A", "count": "15/25"},
        {"time": "6:30 PM", "class": "Power Spin", "type": "Spin", "instructor": "Lisa Rivera", "room": "Room C", "count": "20/20"},
    ]
    context = {
        "page_title": "Daily Schedule Report",
        "rows": rows,
        "totals": {
            "classes": 6,
            "enrolled": 112,
            "avg_capacity": "77%",
            "rooms_used": 3,
        },
    }
    return render(request, "class_ops/daily_schedule.html", context)
