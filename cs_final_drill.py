from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from bcrypt import Bcrypt
from jwt import JWTManager, create_access_token, jwt_required
import datetime

app = Flask(__name__)



app.config['SQLALCHEMY_DATABASE_URI'] = 'https://github.com/Czarap/Event_planner'  
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = 'czar'  

db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)
