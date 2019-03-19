from datetime import datetime

class Favorite:
    def __init__(self, db):
        self.db = db

    def addAspect (self, aspect_id, user_id):
        add = self.db.prepare('INSERT INTO favorite_aspects (user_id, aspect_id, date) VALUES ($1, $2, $3)')
        result = add(user_id, aspect_id, str(datetime.now()))

        if result[1] != 1:
            return False

        return True
