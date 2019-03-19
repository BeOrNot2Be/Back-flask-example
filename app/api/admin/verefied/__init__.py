from flask_restful import Resource
from flask import request
import secrets, postgresql, os

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class EducationVerefizied(Resource):
    def update(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return {'status': False, 'message': 'Fack token, allday'}, 401
            
        verefied_education = database.prepare('UPDATE educations SET verification = true WHERE user_id = $1')
        result = verefied_education(int(id))
            
        if result[1] == 1:
            verefied_education = database.prepare('DELETE * FROM education_verifications WHERE user_id = $1')                
            result = verefied_education(int(id))
            if result[1] == 1:
                return {'status' : True}
        return {'status' : False}

class ProfileVerefizied(Resource):
    def get(self, id):
        token = request.headers.get('token', False)
        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT U.id, U.email, U.fullname, V.verefizied  FROM users as U INNER JOIN verefication as V ON U.id = V.id and U.id = $1")
        user_result = query(int(id))

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404
        #
        user = user_result[0]
        return {'status': True,
                'user': user}


    def post(self, id):
        token = request.headers.get('token', False)
        verefizied_statement = request.json.get('verefizied', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("Update verefication set verefizied = $1 WHERE id = $2")
        user_verefizied = query(verefizied_statement, int(id))

        if len(user_verefizied) == 0: return { 'status': False, 'message': 'User not found' }, 404

        return {'status': True,
                'user': int(id),
                'verefizied': verefizied_statement}
    