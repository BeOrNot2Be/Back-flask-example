from flask_restful import Resource
from flask import request
from datetime import date
import secrets, postgresql, os, datetime

from config import LINK, DATABASE_PATH, UPLOAD

database = postgresql.open(DATABASE_PATH)

class AMute(Resource):
    def get(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id FROM users WHERE token = $1")
        users = query(token)

        if len(users) == 0: return { 'status': False, 'message': 'User not found' }, 404

        query = database.prepare('SELECT * from mute WHERE id = $1')
        result = query(int(id))
        if result:
            return {'status': True,
                    'comment': result[0]['comment'],
                    'mark':  result[0]['mark']}
        return {'status': False}
        
    def delete(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id FROM users WHERE token = $1")
        users = query(token)

        if len(users) == 0: return {'status': False, 'message': 'User not found'}, 404

        query = database.prepare('DELETE from mute WHERE user = $1')
        delete = query(int(id))
        if delete:
            return {'status': True}
        return {'status': False}


    def post(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id FROM users WHERE token = $1")
        users = query(token)

        if len(users) == 0: return { 'status': False, 'message': 'User not found' }, 404

        mark = request.json.get('mark', False)
        comment = request.json.get('comment', False)

        query = database.prepare('INSERT INTO mute (id, comment, mark) VALUES ($1, $2, $3)')
        insert = query(int(id), comment, mark)

        if insert[1] == 1:
            return {'status': True}
        return {'status': False}
