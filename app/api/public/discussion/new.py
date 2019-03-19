from flask_restful import Resource
from flask import request
import secrets, postgresql, os, json
from datetime import datetime

from config import DATABASE_PATH, UPLOAD, LINK

database = postgresql.open(DATABASE_PATH)

class CreateDiscussion(Resource):
    def put(self):
        token = request.headers.get('token', False)

        if not token or len(token) < 5: return { 'status': False, 'message': 'Fack token, allday' }, 401

        query = database.prepare("SELECT id, email, fullname FROM users WHERE token = $1")
        user_result = query(token)

        user = user_result[0]

        discussion_title = request.form.get('title', False)
        discussion_cover = request.files.get('cover', False)

        aspect_id = request.form.get('aspect_id', False)
        aspect_title = request.form.get('aspect_title', False)
        aspect_image = request.files.get('aspect_image', False)

        argument_position = request.form.get('argument_position', False)
        argument_description = request.form.get('argument_description', False)
        argument_links = json.loads(request.form['argument_links']) if request.form.get('argument_links', False) else False
        argument_file1 = request.files.get('argument_file1', False)
        argument_file2 = request.files.get('argument_file2', False)

        if not discussion_title or not discussion_cover:
            return {
                'status': False,
                'message': 'Discussion title or image is empty'
            }, 400

        if not (aspect_title or aspect_image):
            if not aspect_id:
                return {
                    'status': False,
                    'message': 'Aspect is empty'
                }, 400

        if not argument_position or not argument_description:
            return {
                'status': False,
                'message': 'Argument position or description is empty'
            }, 400

        discussion = self.createDiscussion(user, discussion_title, discussion_cover)
        aspect = self.createAspect(user, discussion, aspect_id, aspect_title, aspect_image) if discussion else False
        argument = self.createArgument(discussion, aspect, argument_position, argument_description, argument_links, argument_file1, argument_file2) if aspect else False
        # aspect = True
        # argument = True

        if discussion and aspect and argument:
            return {
                'status': True,
                'result': discussion
            }

        return {
            'status': False
        }

    def createDiscussion (self, user, title, image):
        image.save(os.getcwd() + os.path.join(UPLOAD.DISCUSSION, image.filename))
        query = database.prepare('INSERT INTO discussions (title, image, author) VALUES ($1, $2, $3)')
        result = query(title, image.filename, int(user['id']))

        if result[1] == 1:
            select = database.prepare('SELECT id FROM discussions WHERE title = $1 AND image = $2')
            discussions = select(title, image.filename)

            if len(discussions) > 0:
                discussion = discussions[0]
                return {
                    'id': discussion['id'],
                    'title': title,
                    'image': LINK + UPLOAD.DISCUSSION + image.filename
                }

        return False

    def createAspect (self, user, discussion, id, title, image):
        if id:
            select = database.prepare('SELECT * from aspects WHERE id = $1')
            aspects = select(int(id))
            if len(aspects) > 0:
                aspect = aspects[0]
                query = database.prepare('INSERT INTO discussion_aspects (discussion_id, aspect_id) VALUES ($1, $2)')
                query(int(discussion['id']), int(aspect['id']))
                return aspect

            return False
        else:
            image.save(os.getcwd() + os.path.join(UPLOAD.ASPECTS, image.filename))
            query = database.prepare('INSERT INTO aspects (title, image) VALUES ($1, $2)')
            insert = query(title, image.filename)
            if insert[1] == 1:
                select = database.prepare('SELECT * FROM aspects WHERE title = $1 AND image = $2')
                aspects = select(title, image.filename)
                if len(aspects) > 0:
                    aspect = aspects[0]

                    query = database.prepare('INSERT INTO favorite_aspects (user_id, aspect_id, date) VALUES ($1, $2, $3)')
                    query(int(user['id']), int(aspect['id']), str(datetime.now()))

                    query = database.prepare('INSERT INTO discussion_aspects (discussion_id, aspect_id) VALUES ($1, $2)')
                    query(int(discussion['id']), int(aspect['id']))

                    return {
                        'id': aspect['id'],
                        'title': aspect['title'],
                        'image': LINK + UPLOAD.ASPECTS + aspect['image'],
                    }

            return False

    def createArgument (self, discussion, aspect, position, description, links, file1, file2):
        files = []
        if file1:
            file1.save(os.getcwd() + os.path.join(UPLOAD.ARGUMENT, file1.filename))
            files.append(file1.filename)
        if file2:
            file2.save(os.getcwd() + os.path.join(UPLOAD.ARGUMENT, file2.filename))
            files.append(file2.filename)

        position = 1 if int(position) == 1 else 0

        print(discussion['id'], aspect['id'], position, description, json.dumps(links), json.dumps(files))

        insert = database.prepare("INSERT INTO discussion_arguments (discussion_id, aspect_id, description, position, links, files) VALUES ($1, $2, $3, $4, $5, $6)")
        argument = insert(int(discussion['id']), int(aspect['id']), description, int(position), json.dumps(links), json.dumps(files))

        if argument[1] == 1:
            return True
        return False

    def get (self):
        sort = request.args.get('sort', False)
        search = request.args.get('search', False)

        if sort == 'popular':
            query = ''
        if sort == 'last':
            query = 'ORDER BY id DESC'
        else:
            query = ''

        if search and sort:
            query += " AND title LIKE '%"+search+"%'"
        elif search and not sort:
            query = "WHERE title LIKE '%"+search+"%'"


        query = 'SELECT * FROM discussions ' + query
        print(query)
        discussionQuery = database.prepare(query)
        discussions = discussionQuery()

        result = []

        for discussion in discussions:
            item = {
                'id': discussion['id'],
                'title': discussion['title'],
                'image': LINK + UPLOAD.DISCUSSION + discussion['image'],
            }

            if discussion['author']:
                userQuery = database.prepare('SELECT id, fullname, avatar FROM users WHERE id = $1')
                users = userQuery(discussion['author'])

                if len(users) > 0:
                    user = users[0]
                    item['author'] = {}
                    item['author']['id'] = user['id']
                    item['author']['fullname'] = user['fullname']
                    item['author']['avatar'] = LINK + UPLOAD.AVATAR + user['avatar']

            result.append(item)


        return {
            'status': True,
            'result': result
        }
