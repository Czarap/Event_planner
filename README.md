# Project_Title
	Event planner
## Description
The Event-Planner Data Model is designed to streamline the management of events by providing a structured framework for organizing information about organizers, venues, events, participants, and resources. It supports event planners in coordinating  tracking details, and ensuring smooth execution of events

# Installation
[DATABASE_URL]-(https://github.com/Czarap/Event_planner/blob/main/cs.sql)
```cmd
pip install -r requirements.txt

## Configuration
Environment variables needed:
	python -m pip install flask
	python -m pip install flask_sqlalchemy
	python -m pip install flask_jwt_extended
    python -m pip install pytest

SECRET_KEY

## API Endpoints (markdown table)
Endpoint				Method		Description
=====================================
http://127.0.0.1:5000/events	        GET			        List of the Events
http://127.0.0.1:5000/login		    POST		           Log in for  JWT authentication token
												       log in details {
											          "email": "admin@gmail.com",
											          "password": "password"
												                    	}
http://127.0.0.1:5000/events	    POST                Create a new data table
                                                        {
                                                            "Event_Status_Code": 1,
                                                            "Event_Type_Code": 2,
                                                             "Organizer_ID": 3,
                                                             "Venue_ID": 4,
                                                             "Event_Name": "Test CREATE",
                                                               "Event_Start_Date": "2024-01-10",
                                                             "Event_End_Date": "2024-01-12",
                                                              "Number_of_Participants": 200,
                                                              "Event_Duration": 3,
                                                            "Potential_Cost": 15000.00
                                                                }




http://127.0.0.1:5000/events/<int:event_id> GET         Retrieve data of the event_id
http://127.0.0.1:5000/events/<int:event_id>  Delete     Delete data of the event_id
http://127.0.0.1:5000/events/<int:event_id>     PUT     Updates existing data of the event_id
                                                        {
                                                          "Event_Status_Code": 2,
                                                         "Event_Name": "Test Update",
                                                         "Event_Start_Date": "2024-01-11",
                                                         "Event_End_Date": "2024-01-13",
                                                          "Number_of_Participants": 250,
                                                          "Potential_Cost": 18000.00
}