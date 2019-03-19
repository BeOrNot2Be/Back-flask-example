from flask_restful import Resource
from flask import request
import secrets, postgresql, os

from config import LINK, DATABASE_PATH, UPLOAD

database = postgresql.open(DATABASE_PATH)

class FavoriteUsers(Resource):
    def get(self):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id FROM users WHERE token = $1")
        users = query(token)

        if len(users) == 0: return { 'status': False, 'message': 'User not found' }, 404
        user = users[0]

        query = database.prepare("SELECT * FROM favorite_users WHERE author_id = $1")
        favorite_users = query(int(user['id']))

        if len(favorite_users) == 0: return { 'status': True, 'result': [] }

        result_users = []
        for favorite_user in favorite_users:
            getUser = database.prepare('SELECT id, fullname, avatar FROM users WHERE id = $1')
            user = getUser(int(favorite_user['user_id']))[0]

            result_users.append({
                'id': user['id'],
                'fullname': user['fullname'],
                'avatar': LINK + UPLOAD.AVATAR + user['avatar'],
            })

        return { 'status': True, 'result': result_users }
