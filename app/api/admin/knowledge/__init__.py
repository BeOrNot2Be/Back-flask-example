from flask_restful import Resource
from flask import request
import secrets, postgresql, os

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class KnowladgeReset(Resource):

    def delete(self):
        token = request.headers.get('token', False)
        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401
        
        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404
                
        reset = database.prepare('DELETE FROM user_knowledges')
        if reset()[0] == "DELETE":
            return {'status': True}
        return {'status': False}
