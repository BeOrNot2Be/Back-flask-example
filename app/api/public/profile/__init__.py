from flask_restful import Resource
from flask import request
import secrets, postgresql, os

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class Profile(Resource):
    def get(self, id):
        query = database.prepare("SELECT id, email, fullname, avatar FROM users WHERE id = $1")
        result = query(int(id))

        if len(result) == 0: return { 'status': False, 'message': 'User not found' }, 404

        user = result[0]
        education = self.getEducation(int(id))

        return {
            'status': True,
            'result': {
                'id': user['id'],
                'email': user['email'],
                'fullname': user['fullname'],
                'avatar': LINK + UPLOAD.AVATAR + user['avatar'],
                'education': education
            }
        }

    def getEducation(self, id):
        query = database.prepare("SELECT * FROM educations WHERE user_id = $1")
        result = query(id)

        if len(result) == 0:
            return {
                'country': '',
                'city': '',
                'hight_school': '',
                'faculty': '',
                'specialty': '',
                'scan': '',
                'date': '',
                'verification': False
            }

        education = result[0]

        return {
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

    def post(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id FROM users WHERE id = $1 AND token = $2")
        result = query(int(id), token)

        if len(result) == 0: return { 'status': False, 'message': 'User not found' }, 404

        if 'avatar' in request.files:
            return self.setAvatar(token, request.files['avatar'])

        old_email = request.form.get('old_email', False)
        new_email = request.form.get('new_email', False)

        if old_email and new_email:
            return self.setEmail(token, old_email, new_email)

        old_password = request.form.get('old_password', False)
        new_password = request.form.get('new_password', False)

        if old_password and new_password:
            return self.setPassword(token, old_password, new_password)

        return {
            'status': False
        }

    def setAvatar(self, token, avatar):
        if avatar.filename == '':
            return { 'status': False, 'message': 'Avatar file is empty' }
        avatar.save(os.getcwd() + os.path.join(UPLOAD.AVATAR, avatar.filename))
        return { 'status': True }


    def setEmail(self, token, old_email, new_email):
        if old_email == new_email: return { 'status': False, 'message': 'Old email is equal to new email' }
        if len(old_email) < 5 or len(new_email) < 5: return { 'status': False, 'message': 'Email length is low' }, 401

        query = database.prepare('UPDATE users SET email = $1 WHERE token = $2 AND email = $3')
        result = query(new_email, token, old_email)

        if result[1] == 1: return { 'status': True }, 200
        return { 'status': False, 'message': 'Range error' }, 401

    def setPassword(self, token, old_password, new_password):
        if old_password == new_password: return { 'status': False, 'message': 'Old password is equal to new password' }
        if len(old_password) < 5 or len(new_password) < 5: return { 'status': False, 'message': '' }

        query = database.prepare('UPDATE users SET password = $1 WHERE token = $2 AND password = $3')
        result = query(new_password, token, old_password)

        if result[1] == 1: return { 'status': True }, 200
        return { 'status': False, 'message': 'Range error' }, 401

    def update(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return {'status': False, 'message': 'Fack token, allday'}, 401
        
        query = database.prepare("SELECT * FROM educations WHERE user_id = $1")
        result = query(id)
        education = result[0] if len(result) > 0 else False

        query = database.prepare("SELECT * FROM users WHERE id = $1")
        result = query(id)
        users_data = result[0] if len(result) > 0 else False

        country         = request.form.get('country', education['country'] if education != False else '')
        city            = request.form.get('city', education['city'] if education != False else '')
        hight_school    = request.form.get('hight_school', education['hight_school'] if education != False else '')
        faculty         = request.form.get('faculty', education['faculty'] if education != False else '')
        specialty       = request.form.get('specialty', education['specialty'] if education != False else '')
        date            = request.form.get('date', education['date'] if education != False else '')
        email           = request.form.get('email', users_data['email'] if users_data != False else '')
        fullname        = request.form.get('fullname', users_data['fullname'] if users_data != False else '')
        
        users_info = database.prepare("UPDATE users SET email= $1, fullname = $2 FROM users WHERE id = $3")
        result1 = users_info(email, fullname, int(id))
        
        general_info = database.prepare('UPDATE educations SET country = $1, city = $2, hight_school = $3, faculty = $4, specialty = &5, date = &6 WHERE user_id = $7')
        result = general_info(country, city, hight_school, faculty, specialty, date, int(id))

        if result[1] == 1 and result1[1] == 1:#check
            return {'status' : True}
        return {'status' : False}

