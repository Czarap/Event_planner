from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager, create_access_token, jwt_required
import datetime

app = Flask(__name__)



app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://username:password@localhost:3306/cs.sql'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = 'czar'  

db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)


class Venue(db.Model):
    __tablename__ = 'venues'
    Venue_ID = db.Column(db.Integer, primary_key=True)
    Venue_Name = db.Column(db.String(255), nullable=False)
    Other_Details = db.Column(db.Text)

class Organizer(db.Model):
    __tablename__ = 'organizers'
    Organizer_ID = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(255), nullable=False)
    Email_Address = db.Column(db.String(255), nullable=False, unique=True)
    Contact_ID = db.Column(db.Integer)
    Address_ID = db.Column(db.Integer)
    Web_Site_Address = db.Column(db.String(255))
    Mobile_Number = db.Column(db.String(20))

class RefEventStatus(db.Model):
    __tablename__ = 'ref_event_status'
    Event_Status_Code = db.Column(db.Integer, primary_key=True)
    Event_Status_Description = db.Column(db.String(255), nullable=False)

class RefEventType(db.Model):
    __tablename__ = 'ref_event_types'
    Event_Type_Code = db.Column(db.Integer, primary_key=True)
    Event_Type_Description = db.Column(db.String(255), nullable=False)

class Event(db.Model):
    __tablename__ = 'events'
    Event_ID = db.Column(db.Integer, primary_key=True)
    Event_Status_Code = db.Column(db.Integer, db.ForeignKey('ref_event_status.Event_Status_Code'))
    Event_Type_Code = db.Column(db.Integer, db.ForeignKey('ref_event_types.Event_Type_Code'))
    Organizer_ID = db.Column(db.Integer, db.ForeignKey('organizers.Organizer_ID'))
    Venue_ID = db.Column(db.Integer, db.ForeignKey('venues.Venue_ID'))
    Event_Name = db.Column(db.String(255), nullable=False)
    Event_Start_Date = db.Column(db.Date, nullable=False)
    Event_End_Date = db.Column(db.Date, nullable=False)
    Number_of_Participants = db.Column(db.Integer)
    Event_Duration = db.Column(db.Integer)
    Potential_Cost = db.Column(db.Numeric(10, 2))
