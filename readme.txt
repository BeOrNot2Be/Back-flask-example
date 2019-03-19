knowledges response:
DELETE: /api/public/profile/<id>/knowledge

user likes:*

DELETE: /api/likes/user/<id>
POST: /api/likes/user/<id> (users id whom we liked)
GET: /api/likes/user/<id> (return how many likes and true if user who send request already liked )

comment likes:*

DELETE: /api/likes/comment/<id>
POST: /api/likes/comment/<id> (comment id which we liked)
GET: /api/likes/comment/<id> (return how many likes and true if user who send request already liked )

verifecation:*

GET: /api/public/profile/<id>/verefied (user id)
UPDATE: /api/public/profile/<id>/verefied (data: verefizied true/flalse)

mute:*

DELETE: /api/mute_users/<id>
POST: /api/mute_users/<id> (comment, mark bool)
GET: /api/mute_users/<id>

top users:!!

GET: /api/users/top

country data:

GET: /api/marks/gen/<country>

claims:*

DELETE: /api/claims/<id>
POST: /api/claims/<id> (claim id, title, description)
GET: /api/claims/<id>

argument:

DELETE: /api/public/discussions/<id>/arguments

tesis take a look

alerts:

UPDATE: /api/claims/<id> (text, alert id)
GET: /api/claims/<id> (disscusion if)

Profile update/delete

education: 

UPDATE: /api/public/profile/<id>/education

rewards:*

DELETE: /api/claims/<id> 
GET: /api/claims/<id> (reward_id\)


