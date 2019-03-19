from flask_restful import Resource
from flask import request
import secrets, postgresql, os

from config import LINK, DATABASE_PATH, UPLOAD

database = postgresql.open(DATABASE_PATH)

class FavoriteAspects(Resource):
    def get(self):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id FROM users WHERE token = $1")
        users = query(token)

        if len(users) == 0: return { 'status': False, 'message': 'User not found' }, 404
        user = users[0]
        #
        query = database.prepare("SELECT * FROM favorite_aspects WHERE user_id = $1")
        favorite_aspects = query(int(user['id']))

        if len(favorite_aspects) == 0:
            return {
                'status': True,
                'result': []
            }


        result_aspects = []
        for favorite_aspect in favorite_aspects:
            getAspect = database.prepare('SELECT id, title, image FROM aspects WHERE id = $1')
            aspect = getAspect(int(favorite_aspect['aspect_id']))[0]

            result_aspects.append({
                'id': aspect['id'],
                'title': aspect['title'],
                'image': LINK + UPLOAD.ASPECTS + aspect['image'],
            })

        return {
            'status': True,
            'result': result_aspects
        }
