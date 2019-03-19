from flask_restful import Resource
from flask import request
import secrets
import postgresql

from config import DATABASE_PATH

database = postgresql.open(DATABASE_PATH)

class LikesComment(Resource):
    def get(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id FROM users WHERE token = $1")
        users = query(token)

        if len(users) == 0: return { 'status': False, 'message': 'User not found' }, 404
        user_id = users[0]


        query = database.prepare("select count(*) from comments_liked where like_comment_id = $1")
        answer = query(int(id))[0][0]

        return {'status': True, 'value': answer}


    def post(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id FROM users WHERE token = $1")
        users = query(token)

        if len(users) == 0: return { 'status': False, 'message': 'User not found' }, 404
        user = users[0]

        user_id = request.json.get('user_id', 0)

        query = database.prepare("select exists(select true from comments_liked where user_id = $1 and like_comment_id = $2)")
        liked = query(int(user_id), int(id))[0][0]


        if liked:
            query = database.prepare("DELETE FROM comments_liked WHERE user_id = $1 and like_comment_id = $2")
            delete = query(int(user_id), int(id))
            if delete[1] == 1:
                return {'status': True}


        if not liked:
            query = database.prepare("INSERT INTO comments_liked (user_id, like_comment_id) VALUES ($1, $2)")
            insert = query(int(user_id), int(id))

            
            if insert:
                return {'status': True}
        return {'status': False}
        