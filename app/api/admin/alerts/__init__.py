from flask_restful import Resource
from flask import request
import secrets, postgresql, os, json
from datetime import datetime

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class Alerts(Resource):
    def get(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        user = user_result[0]

        query = database.prepare('SELECT * FROM alerts WHERE disscution_id = $1')
        alerts = query(int(id))

        return {
            'status': True,
            'result': alerts
        }



    def post(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        user = user_result[0]
        text = request.json.get('text', False)
        query = database.prepare('UPDATE alerts SET description = $1 WHERE disscution_id = $2')
        alerts = query(text, int(id))

        if alerts[1] == 1:
            return {'status': True}
        return {'status': False}