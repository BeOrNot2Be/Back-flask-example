class Aspects:
    def __init__(self, db):
        self.db = db

    def getList (self):
        query = self.db.prepare('SELECT * FROM aspects')
        return query()

    def getListInit (self):
        query = self.db.prepare('SELECT * FROM aspects WHERE init = 1')
        return query()
