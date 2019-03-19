from flask_restful import Resource
from flask import request
from datetime import date
import secrets, postgresql, os, datetime

from config import LINK, DATABASE_PATH, UPLOAD

database = postgresql.open(DATABASE_PATH)
class RewardsUpdate(Resource):
    def delete(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404

        reward_id = request.headers.get('reward_id', False)

        deleteReward = database.prepare('DELETE FROM user_rewards WHERE user_id = $1 and reward_id = $2')
        delete = deleteReward(int(id), reward_id)

        if delete: 
            return {'status': True}
        return {'status': False}

    def post(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        if len(user_result) == 0: return { 'status': False, 'message': 'User not found' }, 404

        reward_id = request.json.get('reward_id', False)
        newReward = database.prepare('INSERT INTO user_rewards (user_id, reward_id, date) VALUES ($1, $2, NOW())')
        new = newReward(int(id), reward_id)

        if new: 
            return {'status': True}
        return {'status': False}