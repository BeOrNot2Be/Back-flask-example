LINK = 'http://localhost:5000'
import os
#DATABASE_PATH = os.environ['DATABASE_URL'].replace('postgres', 'pq')
DATABASE_PATH = 'pq://postgres:root@127.0.0.1:5432/sft'
class UPLOAD:
    AVATAR = '/upload/avatar/'
    EDUCATION = '/upload/education/'
    ASPECTS = '/upload/aspects/'
    REWARD = '/upload/rewards/'
    KNOWLEDGE = '/upload/knowledges/'
    DISCUSSION = '/upload/discussions/'
    ARGUMENT = '/upload/arguments/'
    EDUCATION = '/upload/education/'
