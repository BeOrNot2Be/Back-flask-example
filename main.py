from flask import Flask
from flask_cors import CORS
from flask_restful import Resource, Api

from app.api import routes

app = Flask(__name__)
CORS(app)
api = Api(app)
for route in routes:
    api.add_resource(route['component'], route['path'])

if __name__ == "__main__":
    app.debug = True
    app.run()
