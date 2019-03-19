from flask_restful import Resource
from flask import request
import secrets, postgresql, os, json
from datetime import datetime

from config import DATABASE_PATH, UPLOAD, LINK


database = postgresql.open(DATABASE_PATH)

class Aspects(Resource):
    def get(self, id):
        query = database.prepare('SELECT * FROM discussion_aspects INNER JOIN aspects ON discussion_aspects.aspect_id = aspects.id WHERE discussion_id = $1')
        aspects = query(int(id))

        result = []

        for aspect in aspects:
            item = {
                'id': aspect['aspect_id'],
                'title': aspect['title'],
                'image': LINK + UPLOAD.ASPECTS + aspect['image']
            }
            result.append(item)

        return {
            'status': True,
            'result': result
        }

    def put(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        user = user_result[0]

        aspect_title = request.form.get('aspect_title', False)
        aspect_image = request.files.get('aspect_image', False)

        if not (aspect_title or aspect_image):
            return {
                'status': False,
                'message': 'Aspect is empty'
            }, 400

        result = self.createAspect(user, id, aspect_title, aspect_image)

        if not result:
            return {
                'status': False,
                'message': 'Произошла ошибка'
            }
            
        return {
            'status': True,
            'result': result
        }

    def createAspect (self, user, discussion_id, title, image):
        image.save(os.getcwd() + os.path.join(UPLOAD.ASPECTS, image.filename))

        query = database.prepare('INSERT INTO aspects (title, image) VALUES ($1, $2)')
        insert = query(title, image.filename)

        if insert[1] == 1:
            select = database.prepare('SELECT * FROM aspects WHERE title = $1 AND image = $2')
            aspects = select(title, image.filename)
            if len(aspects) > 0:
                aspect = aspects[0]

                query = database.prepare('INSERT INTO favorite_aspects (user_id, aspect_id, date) VALUES ($1, $2, $3)')
                query(int(user['id']), int(aspect['id']), str(datetime.now()))

                query = database.prepare('INSERT INTO discussion_aspects (discussion_id, aspect_id) VALUES ($1, $2)')
                query(int(discussion_id), int(aspect['id']))

                return {
                    'id': aspect['id'],
                    'title': aspect['title'],
                    'image': LINK + UPLOAD.ASPECTS + aspect['image'],
                }

        return False
