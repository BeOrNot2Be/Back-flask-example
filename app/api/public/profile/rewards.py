from flask_restful import Resource
from flask import request
from datetime import date
import secrets, postgresql, os, datetime

from config import LINK, DATABASE_PATH, UPLOAD

database = postgresql.open(DATABASE_PATH)

class Rewards(Resource):
    def get(self, id):
        query = database.prepare("SELECT * FROM user_rewards WHERE user_id = $1")
        user_rewards = query(int(id))

        if len(user_rewards) == 0:
            return {
                'status': True,
                'result': []
            }

        result_rewards = []
        for user_reward in user_rewards:
            getReward = database.prepare('SELECT id, title, description, image FROM rewards WHERE id = $1')
            reward = getReward(int(user_reward['reward_id']))[0]

            result_rewards.append({
                'id': reward['id'],
                'title': reward['title'],
                'description': reward['description'],
                'image': LINK + UPLOAD.REWARD + reward['image'],
                'date': user_reward['date']
            })

        return {
            'status': True,
            'result': result_rewards
        }
