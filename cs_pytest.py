import unittest
from cs_final_drill import app, db

class FlaskAppTestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        self.client = app.test_client()
        with app.app_context():
            db.create_all()

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



if __name__ == '__main__':
    unittest.main()
