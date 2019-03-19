from flask_restful import Resource
from flask import request
import secrets
import postgresql

from config import DATABASE_PATH

database = postgresql.open(DATABASE_PATH)

class Login(Resource):
    def post(self):
        email = request.form['email']
        password = request.form['password']

        query = database.prepare("SELECT id, email, password, fullname FROM users WHERE email = $1")
        result = query(email)

        if len(result) == 0 or result[0]['password'] != password:
            return { 'status': False, 'message': 'Password is incorrect' }, 406
        else:
            user = result[0]
            token = secrets.token_hex(10)
            query = database.prepare('UPDATE users SET token = $1 WHERE id = $2')
            result = query(token, user['id'])

            if result[1] == 1:
                return {
                    'status': True,
                    'result': {
                        'token': token,
                        'id': user['id'],
                        'email': user['email'],
                        'fullname': user['fullname'],
                    },
                }, 200
            else:
                return {
                    'status': False,
                    'message': 'Range error'
                }, 406
