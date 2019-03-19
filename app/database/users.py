from datetime import datetime

class Users:
    def __init__ (self, db):
        self.db = db

    def get (self, id):
        query = self.db.prepare('SELECT * FROM users WHERE id = $1')
        result = query(id)

        return {
            'status': True if len(result) > 0 else False,
            'users': result[0]
        }

    def getList (self):
        query = self.db.prepare('SELECT * FROM users')
        result = query()
        return {
            'status': True if len(result) > 0 else False,
            'users': result
        }

class Education:
    def __init__ (self, db):
        self.db = db

    def get (self, user_id):
        query = self.db.prepare('SELECT * FROM educations WHERE user_id = $1')
        result = query(user_id)

        isset = True if len(result) > 0 else False

        if isset:
            education = result[0]

        return {
            'status': isset,
            'education': {
                'country': education['cuntry'] if isset else '',
                'city': education['city'] if isset else '',
                'hight_school': education['hight_school'] if isset else '',
                'faculty': education['faculty'] if isset else '',
                'specialty': education['specialty'] if isset else '',
                'date': education['date'] if isset else '',
                'verification': False
            }
        }

    def edit (self, user_id, country = False, city = False, hight_school = False, faculty = False, specialty = False, date = False, scan = False):
        education = self.get(user_id)

        if education['status']:
            country = country if country else education['country']
            city = city if city else education['city']
            hight_school = hight_school if hight_school else education['hight_school']
            faculty = faculty if faculty else education['faculty']
            specialty = specialty if specialty else education['specialty']
            date = date if date else education['date']
            scan = scan if scan else education['scan']

            return self.update(user_id, country, city, hight_school, faculty, specialty, date, scan)
        else:
            country = country if country else ''
            city = city if city else ''
            hight_school = hight_school if hight_school else ''
            faculty = faculty if faculty else ''
            specialty = specialty if specialty else ''
            date = date if date else ''
            scan = scan if scan else ''

            return self.insert(user_id, country, city, hight_school, faculty, specialty, date, scan)

    def update (self, user_id, country, city, hight_school, faculty, specialty, date, scan):
        query = self.db.prepare('''
            UPDATE educations
            SET country = $1,
                city = $2,
                hight_school = $3,
                faculty = $4,
                specialty = $5,
                date = $6,
                scan = $7,
                verification = $8
            WHERE user_id = $9
        ''')

        result = query(
            country,
            city,
            hight_school,
            faculty,
            specialty,
            str(datetime.now()),
            scan,
            False,
            int(user_id)
        )

        if result[1] == 1:
            return True

        return False

    def insert (self, user_id, country, city, hight_school, faculty, specialty, date, scan):
        query = self.db.prepare('''
            INSERT INTO educations
            (user_id, country, city, hight_school, faculty, specialty, date, scan)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        ''')

        result = query(
            int(user_id),
            country,
            city,
            hight_school,
            faculty,
            specialty,
            date,
            scan
        )

        if result[1] == 1:
            return True
        
        return False




    
