from flask_restful import Resource
from flask import request
import secrets, postgresql, os, json
from datetime import datetime

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class Arguments(Resource):
    def get(self, id):
        query = database.prepare('SELECT * FROM discussion_arguments WHERE discussion_id = $1')
        arguments = query(int(id))

        result = []

        for argument in arguments:
            item = {
                'id': argument['id'],
                'title': argument['title'],
                'image': LINK + UPLOAD.ASPECTS + argument['image'],
                'scores': argument['score']
            }

            
            result.append(item)

        return {
            'status': True,
            'result': result
        }

    def put(self, id):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        user = user_result[0]

        argument_position = request.form.get('argument_position', False)
        argument_description = request.form.get('argument_description', False)
        argument_links = json.loads(request.form['argument_links']) if request.form.get('argument_links', False) else False
        argument_file1 = request.files.get('argument_file1', False)
        argument_file2 = request.files.get('argument_file2', False)
        aspect_id = request.files.get('aspect_id', False)

        if not argument_position or not argument_description:
            return {
                'status': False,
                'message': 'Argument position or description is empty'
            }, 400

        result = self.createArgument(id, aspect_id, argument_position, argument_description, argument_links, argument_file1, argument_file2)

        if not result:
            return {
                'status': False,
                'message': 'Произошла ошибка'
            }

        return {
            'status': True,
            'result': result
        }

    def createArgument(self, discussion_id, aspect_id, position, description, links, file1, file2):
        files = []
        if file1:
            file1.save(os.getcwd() + os.path.join(UPLOAD.ARGUMENT, file1.filename))
            files.append(file1.filename)
        if file2:
            file2.save(os.getcwd() + os.path.join(UPLOAD.ARGUMENT, file2.filename))
            files.append(file2.filename)

        position = 1 if int(position) == 1 else 0

        print(discussion_id, aspect_id, position, description, json.dumps(links), json.dumps(files))

        insert = database.prepare("INSERT INTO discussion_arguments (discussion_id, aspect_id, description, position, links, files) VALUES ($1, $2, $3, $4, $5, $6)")
        argument = insert(int(discussion_id), int(aspect_id), description, int(position), json.dumps(links), json.dumps(files))

        if argument[1] == 1:
            return True
        return False
    