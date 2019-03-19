from flask_restful import Resource
from flask import request
import secrets, postgresql, os

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class TopUsers(Resource):
    def get(self):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404
        #
        user = user_result[0]
        
        top = database.prepare('''
        SELECT * FROM users WHERE ID IN (select DISTINCT o.author from (SELECT author FROM discussions ORDER BY scores DESC) as o limit 10)
        ''')()


        if top:
            return {
                'status': True,
                'top':top
            }
        return { 'status': False}