from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager, create_access_token, jwt_required
import datetime


app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://username:YES@localhost:3306/cs'
app.config['JWT_SECRET_KEY'] = 'czar'  

db = SQLAlchemy(app)
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
#DB
with app.app_context():
    db.create_all()


#API REST Architecture conventions


@app.route('/events', methods=['GET', 'POST'])
@jwt_required()
def handle_events():
#READ
    if request.method == 'GET':
        events = db.session.query(
            Event.Event_ID,
            Event.Event_Name,
            Event.Event_Start_Date,
            Event.Event_End_Date,
            Event.Number_of_Participants,
            RefEventStatus.Event_Status_Description.label('Event_Duration'),
            Event.Potential_Cost
        ).join(
            RefEventStatus, Event.Event_Status_Code == RefEventStatus.Event_Status_Code
        ).order_by(Event.Event_ID.asc()).all()

        return jsonify([{
            'Event_ID': event.Event_ID,
            'Event_Name': event.Event_Name,
            'Event_Start_Date': event.Event_Start_Date.strftime('%Y-%m-%d'),
            'Event_End_Date': event.Event_End_Date.strftime('%Y-%m-%d'),
            'Number_of_Participants': event.Number_of_Participants,
            'Event_Duration': event.Event_Duration,
            'Potential_Cost': str(event.Potential_Cost)
        } for event in events]), 200
#CREATE
    elif request.method == 'POST':
        data = request.json
        new_event = Event(
            Event_Status_Code=data['Event_Status_Code'],
            Event_Type_Code=data['Event_Type_Code'],
            Organizer_ID=data['Organizer_ID'],
            Venue_ID=data['Venue_ID'],
            Event_Name=data['Event_Name'],
            Event_Start_Date=datetime.datetime.strptime(data['Event_Start_Date'], '%Y-%m-%d').date(),
            Event_End_Date=datetime.datetime.strptime(data['Event_End_Date'], '%Y-%m-%d').date(),
            Number_of_Participants=data['Number_of_Participants'],
            Event_Duration=data['Event_Duration'],
            Potential_Cost=data['Potential_Cost']
        )
        db.session.add(new_event)
        db.session.commit()
        return jsonify({'message': 'Event created successfully!'}), 201

@app.route('/events/<int:event_id>', methods=['GET', 'PUT', 'DELETE'])
@jwt_required()
def handle_event(event_id):
    event = Event.query.get_or_404(event_id)
#READ
    if request.method == 'GET':
        return jsonify({
            'Event_ID': event.Event_ID,
            'Event_Name': event.Event_Name,
            'Event_Start_Date': event.Event_Start_Date.strftime('%Y-%m-%d'),
            'Event_End_Date': event.Event_End_Date.strftime('%Y-%m-%d'),
            'Number_of_Participants': event.Number_of_Participants,
            'Event_Duration': event.Event_Duration,
            'Potential_Cost': str(event.Potential_Cost)
        }), 200
#Update
    elif request.method == 'PUT':
        data = request.json
        event.Event_Status_Code = data.get('Event_Status_Code', event.Event_Status_Code)
        event.Event_Type_Code = data.get('Event_Type_Code', event.Event_Type_Code)
        event.Organizer_ID = data.get('Organizer_ID', event.Organizer_ID)
        event.Venue_ID = data.get('Venue_ID', event.Venue_ID)
        event.Event_Name = data.get('Event_Name', event.Event_Name)
        event.Number_of_Participants = data.get('Number_of_Participants', event.Number_of_Participants)
        event.Event_Duration = data.get('Event_Duration', event.Event_Duration)
        event.Potential_Cost = data.get('Potential_Cost', event.Potential_Cost)
        db.session.commit()
        return jsonify({'message': 'Event updated successfully!'}), 200
#DELETE
    elif request.method == 'DELETE':
        try:
            db.session.delete(event)
            db.session.commit()
            return jsonify({'message': 'Event deleted successfully!'}), 200
        except Exception as e:
            print(f"Error deleting event: {str(e)}")
            return jsonify({'message': 'Error deleting event', 'error': str(e)}), 500
#JWT authentication
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    email = data['email']

    if email == 'admin@gmail.com' and data['password'] == 'password':
        token = create_access_token(
            identity=email,
            additional_claims={"sub": "123"},  
            expires_delta=datetime.timedelta(minutes=20) 
        )
        return jsonify({'token': token}), 200
    return jsonify({'message': 'Invalid credentials'}), 401

if __name__ == '__main__':
    app.run(debug=True)