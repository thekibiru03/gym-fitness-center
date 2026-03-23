# gym-fitness-center
This administrative platform streamlines gym operations by centralizing member registration, class scheduling, and instructor assignments into a single staff-facing interface. The system automates core facility tasks such as membership renewals, capacity-aware class enrollments, and equipment maintenance tracking. By integrating financial logging with daily operational reporting, it provides a comprehensive tool for managing all aspects of a fitness center’s day-to-day business.

## User Story
* As an Admin, I want to enter a new member's details and assign them a membership tier, so that they are officially registered in the system and can begin using gym services.
* As an Admin, I want to verify a member's ID and active status upon arrival, so that I can validate their access and maintain an accurate log of gym attendance.
* As an Admin, I want to process a payment and update a member’s expiration date, so that their access remains uninterrupted and our financial records stay up to date.
* As an Admin, I want to define a new fitness class with a specific schedule and room assignment, so that members have a variety of organized activities to choose from.
* As an Admin, I want to assign a qualified instructor to a scheduled class, so that the class is properly staffed and the trainer's shift is accurately recorded.
* As an Admin, I want to enroll a member into a specific class while respecting room capacity limits, so that classes remain safe, organized, and not overbooked.
* As an Admin, I want to view and update the condition of equipment within a specific room, so that I can ensure all machinery is safe for member use and track service history.
* As an Admin, I want to generate a unified report of all classes, trainers, and bookings for a specific day, so that I can have a clear overview of the facility's daily operations.

## Requirements

* This program requires python3.+ (and pip) installed, a guide on how to install python on various platforms can be found [here](https://docs.djangoproject.com/en/6.0/topics/install/#installing-official-release)

## Installation and Set-up

Here is a run through of how to set up the application:
* **Step 1** : Clone this repository using **`https://github.com/thekibiru03/gym-fitness-center.git`**
* **Step 2** : Go to the project root directory and install the virtualenv library using pip an afterwards create a virtual environment. Run the following commands respectively:
    * **`python -m venv .venv`**
    * **`source .venv/Scripts/activate`**
        * Note that you can exit the virtual environment by running the command **`deactivate`**
    * **Step 3** : Download the all dependencies in the requirements.txt using **`pip freeze > requirements.txt`**
    * **Step 4** : Initialize your SQLite database and create the necessary tables: 
    **`python manage.py makemigrations`**
    **`python manage.py migrate`**
    * **Step 5** : Run the Application: **`python manage.py runserver`**

## Technologies Used
* Python 3.14.2
* HTML  
* CSS
* Django-6.0.3
* Postgresql

