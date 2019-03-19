from flask_restful import Resource
from flask import request
import secrets, postgresql, os, json
from datetime import datetime

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class Feedback(Resource):
    def put(self):
        fullname = request.form.get('fullname', False)
        email = request.form.get('email', False)
        theme = request.form.get('theme', False)
        message = request.form.get('message', False)
        file = request.files.get('file', False)

        if not fullname or not email or not theme or not message:
            return {
                'status': False,
                'message': 'Не все поля заполнены'
            }

        insert = database.prepare('INSERT INTO feddback (fullname, email, theme, message, file) VALUES ($1, $2, $3, $4, $5)')
        insert(fullname, email, theme, message, file if file else None)

        return {
            'status': False,
            'message': 'Спасибо за сообщение'
        }
