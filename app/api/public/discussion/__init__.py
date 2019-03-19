from flask_restful import Resource
from flask import request
import secrets, postgresql, os, json
from datetime import datetime

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class Discussion(Resource):
    def get(self, id):
        query = database.prepare('SELECT * FROM discussions WHERE id = $1')
        discussions = query(int(id))

        if len(discussions) == 0: return { 'status': False, 'message': 'Discussion not found' }, 404

        discussion = discussions[0]
        result = {
            'id': discussion['id'],
            'title': discussion['title'],
            'image': LINK + UPLOAD.DISCUSSION + discussion['image'],
            'scores': discussion['scores']
        }

        if discussion['author']:
            query = database.prepare('SELECT fullname, avatar FROM users WHERE id = $1')
            users = query(discussion['author'])
            if len(users) > 0:
                user = users[0]
                result['author'] = {
                    'id': discussion['author'],
                    'fullname': user['fullname'],
                    'avatar': LINK + UPLOAD.AVATAR + user['avatar'],
                }
        query = database.prepare('SELECT count(*)  FROM WHERE against_discussion discussion_id = $1')
        against = query(int(id))        

        query = database.prepare('SELECT count(*)  FROM for_discussion WHERE discussion_id = $1')
        for_ = query(int(id))

        gen = against + for_

        result['voutes'] = {
            'for':round(for_ / gen * 100),
            'against': (100 - round(query / gen * 100))
        }
        
        
        return {
            'status': True,
            'result': result
        }


    def update(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404
        #
        user = user_result[0]

        voice = request.headers.get('voice', False)
        if voice:
            query = database.prepare('INSERT INTO for_discussion (user_id, discussion_id ) VALUES ($1, $2)')
            discussions_add = query(user['id'], int(id))

            query = database.prepare('DELETE  against_discussion WHERE user_id = $1')
            discussions_del = query(user['id'])
        else:
            query = database.prepare('INSERT INTO against_discussion (user_id, discussion_id ) VALUES ($1, $2)')
            discussions_add = query(user['id'], int(id))

            query = database.prepare('DELETE * FROM for_discussion WHERE user_id = $1')
            discussions_del = query(user['id'])
        if discussions_del and discussions_add:
            return {'status': True}
        return {'status': False}