from flask_restful import Resource
from flask import request
import secrets
import postgresql

from config import DATABASE_PATH

database = postgresql.open(DATABASE_PATH)

class Register(Resource):
    def post(self):
        fullname = request.form['fullname']
        email = request.form['email']
        password = request.form['password']

        query = database.prepare("SELECT id FROM users WHERE email = $1")
        result = query(email)

        if len(result) > 0:
            return { 'status': False, 'message': 'Email is used' }, 406
        else:
            token = secrets.token_hex(10)
            query = database.prepare('INSERT INTO users (email, password, fullname, token) VALUES ($1, $2, $3, $4)')
            result = query(email, password, fullname, token)

            if result[1] != 1:
                return {
                    'status': False,
                    'message': 'Range error'
                }, 406

            query = database.prepare('SELECT id FROM users WHERE email = $1')
            user = query(email)[0]

            query = database.prepare('INSERT INTO verefication (id, verefizied) VALUES ($1, false)')
            result = query(user)

            query = database.prepare('SELECT id FROM aspects WHERE init = 1')
            aspects = query()

            for aspect in aspects:
                add = database.prepare('INSERT INTO favorite_aspects (user_id, aspect_id, date) VALUES ($1, $2, $3)')
                add(user['id'], aspect['id'], '')

            return {
                'status': True
            }
