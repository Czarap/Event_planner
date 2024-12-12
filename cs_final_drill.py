from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from bcrypt import Bcrypt
from jwt import JWTManager, create_access_token, jwt_required
import datetime

app = Flask(__name__)

