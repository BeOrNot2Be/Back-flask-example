from flask_restful import Resource
from flask import request
import secrets, postgresql, os, json
from datetime import datetime

from config import DATABASE_PATH, UPLOAD, LINK


database = postgresql.open(DATABASE_PATH)

class GeneralMerks(Resource):
    def get(self, country):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404
        #
        user = user_result[0]
        
        query = database.prepare('SELECT year, against, forr FROM gen_data WHERE country = $1')
        general_marks = query(country)

        return {
            'status':True,
            'data': general_marks
        }