from django.shortcuts import render


def update_equipment(request):
    context = {
        "page_title": "Update Equipment Condition",
        "equipment_list": [
            {"name": "Bench Press #1", "type": "Free Weight", "condition": "Good", "serviced": "2025-02-10"},
            {"name": "Cable Machine", "type": "Machine", "condition": "Needs Repair", "serviced": "2024-11-05"},
            {"name": "Dumbbells (Set)", "type": "Free Weight", "condition": "Good", "serviced": "2025-01-20"},
            {"name": "Leg Press", "type": "Machine", "condition": "Fair", "serviced": "2025-03-01"},
        ],
    }
    return render(request, "facility_admin/update_equipment.html", context)
