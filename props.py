import postgresql
database = postgresql.open( 'pq://postgres:root@localhost:5432/sft')

def check_db(command, args, answer):
    ranswer = database.prepare(command.format(*args))()
    if ranswer == answer:
        return True
    print(answer)
    print(ranswer)
    

checking_list = [

    (
        {
            "url":"/api/admin/knoladge_reset{}",
            "method":"DELETE",
            "url_args":
                [
                    ""
                ],
            "json" : 
                {
                    'status': True
                }, 
            "send" :
                {
                }
        },
        [
            {
                "func":check_db,
                'command': 'select * from user_knowledges',
                "SQL_args":
                [

                ],
                "answer":[],
                "discription": 'check db'
            }
        ]
    ),
    (
        {
            "url":"/api/admin/gen_marks/{}",
            "method":"GET",
            "url_args":
                [
                    "UK"
                ],
            "json" : 
                {   
                    'data': [[2015, 243243, 14431], [2016, 2432, 14466]],
                    'status': True,
                }, 
            "send" :
                {
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/admin/profile_vereficied/{}",
            "method":"GET",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'user': [1, 'rrgvr', 'feve', False],
                    'status': True
                }, 
            "send" :
                {
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/admin/profile_vereficied/{}",
            "method":"POST",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'user': 1,
                    'verefizied': True,
                    'status': True
                }, 
            "send" :
                {
                    'verefizied': True
                }
        },
        [
        ]
    ),
    (
        {#!!!!!!!!!!
            "url":"/api/admin/education_vereficied/{}",
            "method":"POST",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'user': 1,
                    'verefizied': True,
                    'status': True
                }, 
            "send" :
                {
                    'verefizied': True
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/admin/user/{}",
            "method":"POST",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                {
                },
            "form":{
                'country':'uk',
                'city':'Grinvich',
                'hight_school':'st.Vilyam',
                'faculty':'literature',
                'specialty':'writer',
                'date':'12.43.53',
                'email':'32dwop@gmail.com',
                'fullname': 'bob solvie'
            }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/admin/rewards/{}",
            "method":"POST",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                {
                    'reward_id': 1
                }
        },
        [
            #maybe check 
        ]
    ),
    (
        {
            "url":"/api/admin/rewards/{}",
            "method":"DELETE",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                {
                    'reward_id': 1
                }
        },
        [
            #maybe check 
        ]
    ),
    (
        {
            "url":"/api/admin/alerts/{}",
            "method":"GET",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'result': [[1, 'something']],
                    'status': True
                }, 
            "send" :
                {
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/admin/alerts/{}",
            "method":"POST",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                {
                   'text':'not something' 
                }
        },
        [
            {
                "func":check_db,
                'command': 'select * from alerts where disscution_id = {}',
                "SQL_args":
                [
                    '1'
                ],
                "answer":[(1,'not something')],
                "discription": 'check db'
            }
        ]
    ),
    (
        {
            "url":"/api/admin/argument/{}",
            "method":"DELETE",
            "url_args":
                [
                    "6"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                { 
                }
        },
        [
            {
                "func":check_db,
                'command': 'select * from discussion_arguments where id = {}',
                "SQL_args":
                [
                    '6'
                ],
                "answer":[],
                "discription": 'check db'
            }
        ]
    ),
    (
        {
            "url":"/api/admin/claims/{}",
            "method":"GET",
            "url_args":
                [
                    "2"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                { 
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/admin/mute/{}",
            "method":"GET",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                { 
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/admin/mute/{}",
            "method":"POST",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                { 
                    'mark': True,
                    'comment':True
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/publick/claims/{}",
            "method":"POST",
            "url_args":
                [
                    "1"#tesis id
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                { 
                },
            "form":{
                "title":"smth",
                "description":'desc smth',
                "author_id":1
            }
        },
        [
            {
                "func":check_db,
                'command': 'delete from claims where author = {} and tesis_ID = {}',
                "SQL_args":
                [
                    '1', '1'
                ],
                "answer":('DELETE', 1),
                "discription": 'check db'
            }
        ]
    ),
    (
        {
            "url":"/api/publick/likes/user/{}",
            "method":"POST",
            "url_args":
                [
                    "3"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                { 
                    "user_id": 2
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/publick/likes/user/{}",
            "method":"GET",
            "url_args":
                [
                    "3"
                ],
            "json" : 
                {   
                    'status': True, "value":1
                }, 
            "send" :
                { 
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/publick/likes/comment/{}",
            "method":"POST",
            "url_args":
                [
                    "3"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                { 
                    "user_id": 2
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/publick/likes/comment/{}",
            "method":"GET",
            "url_args":
                [
                    "3"
                ],
            "json" : 
                {   
                    'status': True, "value":1
                }, 
            "send" :
                { 
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/publick/top_users",
            "method":"GET",
            "url_args":
                [
                ],
            "json" : 
                {   
                    'status': True,
                }, 
            "send" :
                { 
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/public/tesis/{}",
            "method":"GET",
            "url_args":
                [
                    '1'
                ],
            "json" : 
                {   
                    'status': True,
                }, 
            "send" :
                { 
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/public/tesis/{}",
            "method":"PUT",
            "url_args":
                [
                    '1'
                ],
            "json" : 
                {   
                    'status': True,
                }, 
            "send" :
                { 
                    "x": 10,
                    "y": 10,
                }
        },
        [
        ]
    ),
    (
        {
            "url":"/api/public/tesis/{}",
            "method":"POST",
            "url_args":
                [
                    '1'#users id 
                ],
            "json" : 
                {   
                    'status': True,
                }, 
            "send" :
                { 
                },
            "form" :{
                "argument_id":1,
                "reply_id":1,
                "comment_position":1,
                "comment_description":"smth",
                #links in form
                #files 
            }

        },
        [
        ]
    ),
    (
        {
            "url":"/api/public/tesis_source/{}",
            "method":"PUT",
            "url_args":
                [
                    '1'
                ],
            "json" : 
                {   
                    'status': True,
                }, 
            "send" :
                { 
                    "source":"x"
                }
        },
        [
        ]
    ),

]


'''
    (
        {
            "url":"/api/admin/claims/{}",
            "method":"DELETE",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                { 
                }
        },
        [
            {
                "func":check_db,
                'command': 'select * from discussion_arguments where id = {}',
                "SQL_args":
                [
                    '6'
                ],
                "answer":[],
                "discription": 'check db'
            }
        ]
    ),
    (
        {
            "url":"/api/admin/mute/{}",
            "method":"DELETE",
            "url_args":
                [
                    "1"
                ],
            "json" : 
                {   
                    'status': True
                }, 
            "send" :
                { 
                }
        },
        [
        ]
    ),
    '''
    