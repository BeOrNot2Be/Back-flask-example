from flask_restful import Resource
from flask import request
import secrets, postgresql, os

from config import DATABASE_PATH, UPLOAD

database = postgresql.open(DATABASE_PATH)

class Education(Resource):
    def get(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404
        #
        query = database.prepare("SELECT * FROM educations WHERE user_id = $1")
        result = query(int(user_result[0]['id']))

        if len(result) == 0:
            return {
                'status': True,
                'result': {
                    'country': '',
                    'city': '',
                    'hight_school': '',
                    'faculty': '',
                    'specialty': '',
                    'scan': '',
                    'date': '',
                    'verification': False
                }
            }

        education = result[0]

        return {
            'status': True,
            'result': {
                'id': education['id'],
                'country': education['country'],
                'city': education['city'],
                'hight_school': education['hight_school'],
                'faculty': education['faculty'],
                'specialty': education['specialty'],
                'scan': education['scan'],
                'date': education['date'],
                'verification': education['verification'],
            }
        }

    def post(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id FROM users WHERE token = $1")
        users = query(token)

        if len(users) == 0: return { 'status': False, 'message': 'User not found' }, 404

        user = users[0]

        if int(user['id']) != int(id): return { 'status': False, 'message': 'User id is not real' }

        query = database.prepare("SELECT * FROM educations WHERE user_id = $1")
        result = query(user['id'])
        education = result[0] if len(result) > 0 else False

        country         = request.form.get('country', education['country'] if education != False else '')
        city            = request.form.get('city', education['city'] if education != False else '')
        hight_school    = request.form.get('hight_school', education['hight_school'] if education != False else '')
        faculty         = request.form.get('faculty', education['faculty'] if education != False else '')
        specialty       = request.form.get('specialty', education['specialty'] if education != False else '')
        date            = request.form.get('date', education['date'] if education != False else '')

        if 'scan' in request.files:
            scan = request.files['scan']
            if scan.filename == '':
                return { 'status': False, 'message': 'Scan file is empty' }
            scan.save(os.getcwd() + os.path.join(UPLOAD.EDUCATION, scan.filename))
        else:
            scan_old = education['scan']

        status = False

        if education:
            update_query = database.prepare('UPDATE educations SET country = $1, city = $2, hight_school = $3, faculty = $4, specialty = $5, date = $6, scan = $7, verification = false WHERE user_id = $8')
            result = update_query(country, city, hight_school, faculty, specialty, date, scan.filename if scan else scan_old, user['id'])

            if result[1] == 1:
                status = True
        else:
            insert_education = database.prepare('''
                INSERT INTO educations
                    (user_id, country, city, hight_school, faculty, specialty, date, scan)
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8)''')
            query_education = insert_education(int(user['id']), country, city, hight_school, faculty, specialty, date, scan.filename if scan else scan_old)

            if query_education[1] == 1:
                status = True

        if status:
            addVerification = database.prepare('INSERT INTO education_verifications (user_id) VALUES ($1)')
            addVerification(user['id'])

            return { 'status': True }

        return { 'status': False }
