import unittest
from cs_mock_db import app, db
from sqlalchemy.sql import text


class FlaskAppTestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        app.config['JWT_SECRET_KEY'] = 'czar'
        self.client = app.test_client()
        with app.app_context():
            db.create_all()
            db.session.execute(text("DELETE FROM events"))
            db.session.execute(text("DELETE FROM venues"))
            db.session.execute(text("DELETE FROM organizers"))
            db.session.execute(text("DELETE FROM ref_event_types"))
            db.session.execute(text("DELETE FROM ref_event_status"))

            db.session.commit()

            db.session.execute(
                text("INSERT INTO ref_event_status (Event_Status_Code, Event_Status_Description) VALUES (1, 'Active')")
            )
            db.session.execute(
                text("INSERT INTO ref_event_types (Event_Type_Code, Event_Type_Description) VALUES (1, 'Conference')")
            )
            db.session.execute(
                text("INSERT INTO organizers (Organizer_ID, Name, Email_Address) VALUES (1, 'Organizer A', 'organizer@example.com')")
            )
            db.session.execute(
                text("INSERT INTO venues (Venue_ID, Venue_Name, Other_Details) VALUES (1, 'Venue A', 'Details')")
            )

            db.session.commit()

    def tearDown(self):
        with app.app_context():
            db.session.remove()
            db.drop_all()

    def _get_token(self):
        response = self.client.post('/login', json={'email': 'admin@gmail.com', 'password': 'password'})
        return response.get_json().get('token')

    def test_login_success(self):
        response = self.client.post('/login', json={'email': 'admin@gmail.com', 'password': 'password'})
        self.assertEqual(response.status_code, 200)
        self.assertIn('token', response.get_json())

    def test_login_failure(self):
        response = self.client.post('/login', json={'email': 'admin@gmail.com', 'password': 'wrongpassword'})
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.get_json()['message'], 'Invalid credentials')

    def test_get_events_empty(self):
        token = self._get_token()
        response = self.client.get('/events', headers={'Authorization': f'Bearer {token}'})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json(), [])

    def test_create_event(self):
        token = self._get_token()
        event_data = {
            'Event_Status_Code': 1,
            'Event_Type_Code': 1,
            'Organizer_ID': 1,
            'Venue_ID': 1,
            'Event_Name': 'New Event',
            'Event_Start_Date': '2023-12-01',
            'Event_End_Date': '2023-12-02',
            'Number_of_Participants': 100,
            'Event_Duration': 2,
            'Potential_Cost': 500.00
        }
        response = self.client.post('/events', json=event_data, headers={'Authorization': f'Bearer {token}'})
        self.assertEqual(response.status_code, 201)
        self.assertEqual(response.get_json()['message'], 'Event created successfully!')

    def test_update_event(self):
        token = self._get_token()
    
        self.client.post('/events', json={
            'Event_Status_Code': 1,
            'Event_Type_Code': 1,
            'Organizer_ID': 1,
            'Venue_ID': 1,
            'Event_Name': 'Event to Update',
            'Event_Start_Date': '2023-12-01',
            'Event_End_Date': '2023-12-02',
            'Number_of_Participants': 50,
            'Event_Duration': 1,
            'Potential_Cost': 100.00
        }, headers={'Authorization': f'Bearer {token}'})
        
 
        response = self.client.put('/events/1', json={
            'Event_Name': 'Updated Event',
            'Number_of_Participants': 150
        }, headers={'Authorization': f'Bearer {token}'})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json()['message'], 'Event updated successfully!')

    def test_delete_event(self):
        token = self._get_token()
    
        self.client.post('/events', json={
            'Event_Status_Code': 1,
            'Event_Type_Code': 1,
            'Organizer_ID': 1,
            'Venue_ID': 1,
            'Event_Name': 'Event to Delete',
            'Event_Start_Date': '2023-12-01',
            'Event_End_Date': '2023-12-02',
            'Number_of_Participants': 50,
            'Event_Duration': 1,
            'Potential_Cost': 100.00
        }, headers={'Authorization': f'Bearer {token}'})
        
    
        response = self.client.delete('/events/1', headers={'Authorization': f'Bearer {token}'})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json()['message'], 'Event deleted successfully!')

    def test_event_not_found(self):
        token = self._get_token()
        response = self.client.put('/events/999', json={'Event_Name': 'Non-existent Event'}, headers={'Authorization': f'Bearer {token}'})
        self.assertEqual(response.status_code, 404)
        self.assertEqual(response.get_json()['message'], 'Event not found')

if __name__ == '__main__':
    unittest.main()
