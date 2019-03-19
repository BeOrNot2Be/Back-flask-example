from datetime import datetime

class Rewards:
    def __init__ (self, db):
        self.db = db

    def get (self, id):
        query = self.db.prepare('SELECT * FROM rewards WHERE id = $1')
        result = query(id)

        return result

    def addToUser (self, user_id, reward_id):
        query = self.db.prepare('INSERT INTO user_rewards (user_id, reward_id, date) VALUES ($1, $2, $3)')
        result = query(int(user_id), int(reward_id), str(datetime.now()))

        if result[1] == 1:
            return True

        return False
