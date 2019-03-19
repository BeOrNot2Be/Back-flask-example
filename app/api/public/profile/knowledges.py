from flask_restful import Resource
from flask import request
import secrets, postgresql, os

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class Knowledge(Resource):
    def get(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404
        #
        user = user_result[0]

        knowledges = database.query('SELECT * FROM knowledges')

        result = []

        for knowledge in knowledges:
            item = {
                'knowledge': {
                    'id': knowledge['id'],
                    'title': knowledge['title'],
                    'image': LINK + UPLOAD.KNOWLEDGE + knowledge['image'],
                },
                'score': 0
            }

            getPoints = database.prepare('SELECT * FROM user_knowledges WHERE user_id = $1 AND knowledge_id = $2')
            points = getPoints(user['id'], knowledge['id'])

            if len(points) > 0:
                point = points[0]
                item['score'] = point['score']

            result.append(item)

        return {
            'status': True,
            'result': result
        }

    def post(self, id):
        token = request.headers.get('token', False)
        knowledge_id = request.json.get('id', False)
        score = request.json.get('score', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404
        #
        user = user_result[0]

        if int(user['id']) != int(id): return { 'status': False, 'message': 'Use is not real' }

        if not knowledge_id: return { 'status': False, 'message': 'Knowledge id is empty' }

        if int(score) > 10 or int(score) < 0: return { 'status': False, 'message': 'Max point is 10' }

        knowledge = database.prepare('SELECT title FROM knowledges WHERE id = $1')
        knowledges = knowledge(int(knowledge_id))

        if len(knowledges) == 0: return { 'status': False, 'message': 'Knowledge is not found' }, 404

        knowledges = database.query('SELECT * FROM knowledges')

        count = 0

        for knowledge in knowledges:
            getPoints = database.prepare('SELECT * FROM user_knowledges WHERE user_id = $1 AND knowledge_id = $2')
            points = getPoints(user['id'], knowledge['id'])

            if len(points) > 0 and int(points[0]['knowledge_id']) != int(knowledge_id):
                point = points[0]
                count += point['score']

        print(count)

        if count + score > 20:
            return {
                'status': False,
                'message': 'You use max points'
            }


        getPoint = database.prepare('SELECT id FROM user_knowledges WHERE user_id = $1 AND knowledge_id = $2')
        points = getPoint(int(user['id']), int(knowledge_id))

        if len(points) > 0:
            query = database.prepare('UPDATE user_knowledges SET score = $1 WHERE user_id = $2 AND knowledge_id = $3')
            query(score, int(user['id']), int(knowledge_id))
        else:
            query = database.prepare('INSERT INTO user_knowledges (user_id, knowledge_id, score) VALUES ($1, $2, $3)')
            query(int(user['id']), int(knowledge_id), score)


        return {
            'status': True
        }

