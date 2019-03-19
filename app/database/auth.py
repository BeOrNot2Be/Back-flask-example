import secrets

class Auth:
    def __init__ (self, db):
        self.db = db

    def login (self, email, password):
        query = self.db.prepare("SELECT * FROM users WHERE email = $1")
        result = query(email)

        print(result)

        if len(result) == 0 or result[0]['password'] != password:
            return { 'status': False, 'code': 101 }

        user = result[0]
        token = secrets.token_hex(15)
        query = self.db.prepare('UPDATE users SET token = $1 WHERE id = $2')
        result = query(token, user['id'])

        if result[1] == 1:
            return {
                'status': True,
                'user': user,
                'token': token
            }
        else:
            return {
                'status': False,
                'code': 100
            }

    def register (self, fullname, email, password):
        query = self.db.prepare("SELECT id FROM users WHERE email = $1")
        result = query(email)

        if len(result):
            return {
                'status': False,
                'code': 101
            }

        token = secrets.token_hex(15)
        query = self.db.prepare('INSERT INTO users (email, password, fullname, token) VALUES ($1, $2, $3, $4)')
        result = query(email, password, fullname, token)

        if result[1] != 1:
            return {
                'status': False,
                'code': 100
            }

        query = self.db.prepare('SELECT * FROM users WHERE email = $1')
        result = query(email)

        return {
            'status': True,
            'user': result[0],
            'token': token
        }

    def getUser (self, token):
        query = self.db.prepare("SELECT * FROM users WHERE token = $1")
        result = query(token)

        if len(result) > 0:
            return {
                'status': True,
                'user': result[0],
            }

        return {
            'status': False,
            'code': 100
        }
