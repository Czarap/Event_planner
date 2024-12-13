# Project Title
	Event planner
## Description
Brief description of your system

## Installation
```cmd
pip install -r requirements.txt

## Configuration
Environment variables needed:
	python -m pip install flask
	python -m pip install flask_sqlalchemy
	python -m pip install flask_jwt_extended
    python -m pip install pytest

DATABASE_URL
SECRET_KEY

## API Endpoints (markdown table)
Endpoint						Method		Description
=====================================
http://127.0.0.1:5000/events	GET			List of the Events
http://127.0.0.1:5000/login		POST		Log in for  JWT authentication token
												log in details {
											"email": "admin@gmail.com",
											"password": "password"
													}
													