import unittest
from cs_final_drill import app, db
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

    def test_login_success(self):
        response = self.client.post('/login', json={'email': 'admin@gmail.com', 'password': 'password'})
        self.assertEqual(response.status_code, 200)
        self.assertIn('token', response.get_json())

    def test_login_failure(self):
        response = self.client.post('/login', json={'email': 'admin@gmail.com', 'password': 'wrongpassword'})
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.get_json()['message'], 'Invalid credentials')

    def test_get_tasks_empty(self):
        token = self._get_token()
        response = self.client.get('/tasks', headers={'Authorization': f'Bearer {token}'})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json(), [])

    def test_create_task(self):
        token = self._get_token()
        response = self.client.post('/tasks', json={'title': 'New Task'}, headers={'Authorization': f'Bearer {token}'})
        self.assertEqual(response.status_code, 201)
        self.assertEqual(response.get_json()['message'], 'Task created successfully!')

    def test_update_task(self):
        token = self._get_token()
        self.client.post('/tasks', json={'title': 'Task to Update'}, headers={'Authorization': f'Bearer {token}'})
        response = self.client.put('/tasks/1', json={'title': 'Updated Task', 'completed': True}, headers={'Authorization': f'Bearer {token}'})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json()['message'], 'Task updated successfully!')

    def test_delete_task(self):
        token = self._get_token()
        self.client.post('/tasks', json={'title': 'Task to Delete'}, headers={'Authorization': f'Bearer {token}'})
        response = self.client.delete('/tasks/1', headers={'Authorization': f'Bearer {token}'})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json()['message'], 'Task deleted successfully!')

    def test_task_not_found(self):
        token = self._get_token()
        response = self.client.put('/tasks/999', json={'title': 'Non-existent Task'}, headers={'Authorization': f'Bearer {token}'})
        self.assertEqual(response.status_code, 404)
        self.assertEqual(response.get_json()['message'], 'Task not found')

    def _get_token(self):
        response = self.client.post('/login', json={'email': 'admin@gmail.com', 'password': 'password'})
        return response.get_json()['token']

if __name__ == '__main__':
    unittest.main()