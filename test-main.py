from pprint import pprint
import unittest
import requests
import props
import random

methods = {
    "POST":requests.post,
    "GET":requests.get,
    "PUT":requests.put,
    "DELETE":requests.delete,
}

header = {"token" : 'tokeen' }

def preparation():
    import postgresql
    database = postgresql.open( 'pq://postgres:root@localhost:5432/sft')

    #KnowladgeReset
    for i in range(3):
        database.prepare("insert into user_knowledges (user_id, knowledge_id, score) values ({},{},{})".format(
            random.randint(0,3),
            random.randint(0,3),
            random.randint(0,3)
        ))()
    

    #database.prepare('''insert into discussion_arguments values (6, 23432, 34, 54, 'fevever', '["link"]', '[]', '', null)''')()    
    #database.prepare('''insert into claims values ( 'dcd', 2, 'dcdcdcd', 'some descriptyion')''')
    '''
    for i in range(10):
        disc = database.prepare('insert into discussions ( title, image, author, scores) values ($1,$2,$3,$4)')
        disc('random_name', 'http:/google.com/favicon.icon', i+1, random.randint(0,100000))
    

    for i in range(10):
        disc = database.prepare('insert into users ( fullname, email, password, avatar, token) values ($1,$2,$3,$4,$5)')
        disc('random_name', 'ipman@gmail.com{}'.format(i+1), str(i+1), 'http:/google.com/favicon.icon', str(random.randint(0,100000)))
    '''
    return True

def check(argument, properties):
    global methods, header
    try:
        rexeption = False
        form = argument.get("form")
        call_func = methods[argument.get("method")]
        send = argument.get("send")
        request = call_func('http://127.0.0.1:5000' + argument.get("url").format(*argument.get("url_args")), headers=header, json=send,  data=form)
        print(request.json())
        if request.json() != argument.get("json"):
            pprint(argument.get("json"))     
    except Exception as e:
        print(e)
        rexeption = True
    right = True 
    for rule in properties:
        print(rule.get("discription"))
        if not rule.get("func")(
            rule.get("command"),
            rule.get("SQL_args"),
            rule.get("answer")
        ):
            print("Errore")
            right = False
    if not rexeption and right:
        print("completed") 

if preparation():
    for i, v in props.checking_list:
        print('!!!')
        check(i, v)