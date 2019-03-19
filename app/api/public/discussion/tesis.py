from flask_restful import Resource
from flask import request
import postgresql, os, json
from config import DATABASE_PATH

database = postgresql.open(DATABASE_PATH)

class Tesis(Resource):
    def get(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        user = user_result[0]
        comment = database.prepare("SELECT * FROM argument_comments WHERE id = $1")(int(id))

        if comment:
            return {
                'status': True,
                'result': comment
            }
        return {'status': False}

    def put(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        user = user_result[0]

        x = request.json.get('x')
        y = request.json.get('y')
        scores = round((x * y) / self.checkFludding(user[0]))

        query = database.prepare("UPDATE argument_comments SET score = score + $1 WHERE id = $2")
        comment = query(scores, int(id))
  
        query = database.prepare("SELECT argument_id FROM argument_comments WHERE id = $1")
        argument_id = query(int(id))[0][0]
        print(argument_id)

        query = database.prepare("UPDATE discussion_arguments SET score = score + $1 WHERE id = $2")
        comment = query(scores, int(argument_id))

        query = database.prepare("SELECT discussion_id FROM discussion_arguments WHERE id = $1")
        discussion_id = query(int(argument_id))[0][0]

        query = database.prepare("UPDATE discussions SET scores = scores + $1 WHERE id = $2")
        comment = query(scores, discussion_id)

        query = database.prepare("INSERT INTO fludding (uid, date) VALUES ($1, NOW())")
        comment = query(int(id))

        if comment:
            return {
                'status': True,
            }
        return {
                'status': False,
            }


    def checkFludding(self, id):
        query = database.prepare("SELECT count(date) FROM fludding WHERE uid = $1 AND date >= NOW() - INTERVAL '1 hour'")
        answer =  query(id)
        return answer[0][0] + 1
    

    def post(self, id):# user id 

        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        user = user_result[0]

        argument_id = request.form.get('argument_id', False)
        reply_id = request.form.get('reply_id', False)
        position = request.form.get('comment_position', False)
        description = request.form.get('comment_description', False)
        links = json.loads(request.form['comment_links']) if request.form.get('comment_links', False) else ''
        comment_file1 = request.files.get('comment_file1', False)
        comment_file2 = request.files.get('comment_file2', False)
        

        if not (argument_id or description):
            return {
                'status': False,
                'message': 'TESIS is empty'
            }, 400

        result = self.createTesis(argument_id, reply_id, position, description, links, comment_file1, comment_file2)


        if not result:
            return {
                'status': False,
                'message': 'Произошла ошибка'
            }
            
        return {
            'status': True,
            'result': result
        }

    def createTesis(self, argument_id, reply_id, position, description, links, file1, file2):
        files = []
        if file1:
            file1.save(os.getcwd() + os.path.join(UPLOAD.ARGUMENT, file1.filename))
            files.append(file1.filename)
        if file2:
            file2.save(os.getcwd() + os.path.join(UPLOAD.ARGUMENT, file2.filename))
            files.append(file2.filename)

        position = 1 if int(position) == 1 else 0

        insert = database.prepare("INSERT INTO argument_comments (argument_id, reply_id, position, description, links, files, date, score) VALUES ($1, $2, $3, $4, $5, $6, NOW(), 0)")
        comment = insert(int(argument_id), int(reply_id), int(position), description, json.dumps(links), json.dumps(files))
            
        if comment[1] == 1:
            return True
        return False

class TesisSource(Resource):
    def post(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        user = user_result[0]

        query = database.prepare("SELECT argument_id FROM argument_comments WHERE id = $1")
        argument_id = query(int(id))[0][0]

        query = database.prepare("SELECT discussion_id FROM discussion_arguments WHERE id = $1")
        discussion_id = query(int(argument_id))[0][0]


        mark = request.json.get('source', False)
        if mark == "v":
            update = database.prepare("UPDATE argument_comments SET score = score + 1 WHERE id = $1")

            query = database.prepare("UPDATE discussions SET scores = scores + 1 WHERE id = $1")
            comment = query(discussion_id)

            query = database.prepare("UPDATE discussion_arguments SET score = score + 1 WHERE id = $1")
            comment1 = query(int(argument_id))

            if update(int(id)):
                return {'status':True}
        elif  mark == "x":#apdate table to float
            comment_score = database.prepare("SELECT score FROM argument_comments WHERE id = $1")
            comment_score = comment_score(int(id))[0][0]

            query = database.prepare("SELECT scores FROM discussions WHERE id = $1")
            discussion_score = query(discussion_id)[0][0]

            query = database.prepare("SELECT score FROM discussion_arguments WHERE id = $1")
            argument_score = query(int(argument_id))[0][0]

            if comment_score <= 0.5:
                update = database.prepare("UPDATE argument_comments SET score = 0 WHERE id = $1")

            if comment_score > 0.5:
                update = database.prepare("UPDATE argument_comments SET score = score - 0.5 WHERE id = $1")

            if argument_score <= 0.5:
                query = database.prepare("UPDATE discussion_arguments SET score = 0 WHERE id = $1")
                ardm = query(int(argument_id))

            if argument_score > 0.5:
                query = database.prepare("UPDATE discussion_arguments SET score = score - 0.5 WHERE id = $1")
                ardm = query(int(argument_id))

            if discussion_score <= 0.5:
                query = database.prepare("UPDATE discussions SET scores = 0 WHERE id = $1")
                comment = query(discussion_id)

            if discussion_score > 0.5:
                query = database.prepare("UPDATE discussions SET scores = scores - 0.5 WHERE id = $1")
                comment = query(discussion_id)

            if all([update(int(id)), comment, ardm]):
                return {'status':True}
        return {'status':False} 
        