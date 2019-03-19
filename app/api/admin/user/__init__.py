from flask_restful import Resource
from flask import request
import secrets, postgresql, os

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class User(Resource):
    def delete(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return {'status': False, 'message': 'Fack token, allday'}, 401
        result = []
        
        users_info = database.prepare('DELETE FROM users WHERE id = $1')
        result.append(users_info(id)[1])

        general_info = database.prepare('DELETE FROM educations WHERE user_id = $1')
        result.append(general_info(id)[1])

        rewards_info = database.prepare('DELETE FROM user_rewards WHERE user_id = $1')
        result.append(rewards_info(id)[1])

        rewards_info = database.prepare('DELETE FROM verefication WHERE id = $1')
        result.append(rewards_info(id)[1])
    
        if all(result):#check
            return {'status' : True}
        return {'status' : False}

    def post(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return {'status': False, 'message': 'Fack token, allday'}, 401
        
        query = database.prepare("SELECT * FROM educations WHERE user_id = $1")
        result = query(int(id))
        education = result[0] if len(result) > 0 else False

        query = database.prepare("SELECT * FROM users WHERE id = $1")
        result = query(int(id))
        users_data = result[0] if len(result) > 0 else False

        country         = request.form.get('country', education['country'] if education != False else '')
        city            = request.form.get('city', education['city'] if education != False else '')
        hight_school    = request.form.get('hight_school', education['hight_school'] if education != False else '')
        faculty         = request.form.get('faculty', education['faculty'] if education != False else '')
        specialty       = request.form.get('specialty', education['specialty'] if education != False else '')
        date            = request.form.get('date', education['date'] if education != False else '')
        email           = request.form.get('email', users_data['email'] if users_data != False else '')
        fullname        = request.form.get('fullname', users_data['fullname'] if users_data != False else '')
        
        users_info = database.prepare("UPDATE users SET email= $1, fullname = $2 WHERE id = $3")
        result1 = users_info(email, fullname, int(id))
        
        general_info = database.prepare('UPDATE educations SET country = $1, city = $2, hight_school = $3, faculty = $4, specialty = $5, date = $6 WHERE user_id = $7')
        result = general_info(country, city, hight_school, faculty, specialty, date, int(id))

        if result[1] == 1 and result1[1] == 1:#check
            return {'status' : True}
        return {'status' : False}