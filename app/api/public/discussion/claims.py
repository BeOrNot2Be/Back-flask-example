from flask_restful import Resource
from flask import request
import secrets, postgresql, os, json
from datetime import datetime

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class Claims(Resource):

    def post(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404
        #
        user = user_result[0]
        
        c_title = request.form.get('title', False)
        c_description = request.form.get('description', False)
        author = request.form.get('author_id', False)
        result = self.createClaim(author, id, c_title, c_description)

        if not result:
            return {
                'status': False,
                'message': 'Произошла ошибка'
            }

        return {
            'status': True,
            'result': result
        }

    def createClaim(self, author, tesis_ID, title, description):

        insert = database.prepare("INSERT INTO claims (author, tesis_ID, title, description) VALUES ($1, $2, $3, $4)")
        argument = insert(int(author), int(tesis_ID), title, description)

        if argument[1] == 1:
            return True
        return False
    
    