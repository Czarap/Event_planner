from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
from flask_jwt_extended import JWTManager, create_access_token, jwt_required
import MySQLdb
import MySQLdb.cursors
import datetime

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'username'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'cs'
app.config['JWT_SECRET_KEY'] = 'czar'

mysql = MySQL(app)
jwt = JWTManager(app)

# API: 
@app.route('/events', methods=['GET', 'POST'])
@jwt_required()
def handle_events():
    try:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

        if request.method == 'GET':  # READ
            cursor.execute("""
                SELECT e.Event_ID, e.Event_Name, e.Event_Start_Date, e.Event_End_Date, e.Number_of_Participants, 
                       r.Event_Status_Description, e.Potential_Cost
                FROM events e
                JOIN ref_event_status r ON e.Event_Status_Code = r.Event_Status_Code
                ORDER BY e.Event_ID ASC
            """)
            events = cursor.fetchall()


            if not events:
                return jsonify({'message': 'No events found'}), 404


            result = [{
                'Event_ID': event['Event_ID'],
                'Event_Name': event['Event_Name'],
                'Event_Start_Date': event['Event_Start_Date'].strftime('%Y-%m-%d') if event['Event_Start_Date'] else None,
                'Event_End_Date': event['Event_End_Date'].strftime('%Y-%m-%d') if event['Event_End_Date'] else None,
                'Number_of_Participants': event['Number_of_Participants'],
                'Event_Duration': event['Event_Status_Description'],
                'Potential_Cost': str(event['Potential_Cost'])
            } for event in events]

            return jsonify(result), 200

        elif request.method == 'POST':  # CREATE
            data = request.json
            try:
                cursor.execute("""
                    INSERT INTO events (
                        Event_Status_Code, Event_Type_Code, Organizer_ID, Venue_ID, Event_Name, Event_Start_Date, 
                        Event_End_Date, Number_of_Participants, Event_Duration, Potential_Cost
                    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, (
                    data['Event_Status_Code'], data['Event_Type_Code'], data['Organizer_ID'], data['Venue_ID'],
                    data['Event_Name'], data['Event_Start_Date'], data['Event_End_Date'],
                    data['Number_of_Participants'], data['Event_Duration'], data['Potential_Cost']
                ))
                mysql.connection.commit()
                return jsonify({'message': 'Event created successfully!'}), 201
            except Exception as e:
                mysql.connection.rollback()
                app.logger.error(f"Error creating event: {e}")
                return jsonify({'message': 'Error creating event', 'error': str(e)}), 500

    except Exception as e:
        app.logger.error(f"Unexpected error: {e}")
        return jsonify({'message': 'Internal Server Error', 'error': str(e)}), 500

    finally:
        cursor.close()

#API REST ARCHI
@app.route('/events/<int:event_id>', methods=['GET', 'PUT', 'DELETE'])
@jwt_required()
def handle_event(event_id):
    try:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
#READ
        if request.method == 'GET':  
            cursor.execute("SELECT * FROM events WHERE Event_ID = %s", (event_id,))
            event = cursor.fetchone()

            if not event:
                return jsonify({'message': 'Event not found'}), 404

            return jsonify({
                'Event_ID': event['Event_ID'],
                'Event_Name': event['Event_Name'],
                'Event_Start_Date': event['Event_Start_Date'].strftime('%Y-%m-%d') if event['Event_Start_Date'] else None,
                'Event_End_Date': event['Event_End_Date'].strftime('%Y-%m-%d') if event['Event_End_Date'] else None,
                'Number_of_Participants': event['Number_of_Participants'],
                'Event_Duration': event['Event_Duration'],
                'Potential_Cost': str(event['Potential_Cost'])
            }), 200
#UPDATE
        elif request.method == 'PUT':  
            data = request.json
            try:
                cursor.execute("""
                    UPDATE events
                    SET Event_Status_Code = %s, Event_Type_Code = %s, Organizer_ID = %s, Venue_ID = %s,
                        Event_Name = %s, Number_of_Participants = %s, Event_Duration = %s, Potential_Cost = %s
                    WHERE Event_ID = %s
                """, (
                    data.get('Event_Status_Code'), data.get('Event_Type_Code'), data.get('Organizer_ID'),
                    data.get('Venue_ID'), data.get('Event_Name'), data.get('Number_of_Participants'),
                    data.get('Event_Duration'), data.get('Potential_Cost'), event_id
                ))
                mysql.connection.commit()
                return jsonify({'message': 'Event updated successfully!'}), 200
            except Exception as e:
                mysql.connection.rollback()
                app.logger.error(f"Error updating event: {e}")
                return jsonify({'message': 'Error updating event', 'error': str(e)}), 500
#DELETE
        elif request.method == 'DELETE':  
            try:
                cursor.execute("DELETE FROM events WHERE Event_ID = %s", (event_id,))
                mysql.connection.commit()
                return jsonify({'message': 'Event deleted successfully!'}), 200
            except Exception as e:
                mysql.connection.rollback()
                app.logger.error(f"Error deleting event: {e}")
                return jsonify({'message': 'Error deleting event', 'error': str(e)}), 500

    except Exception as e:
        app.logger.error(f"Unexpected error: {e}")
        return jsonify({'message': 'Internal Server Error', 'error': str(e)}), 500

    finally:
        cursor.close()

# LOGIN jwt authentication
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
