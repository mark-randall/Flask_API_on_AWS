import os
from flask import Flask, jsonify
from flask_migrate import Migrate

app = Flask(__name__, instance_relative_config=True)
app.config.from_mapping(
    SECRET_KEY=os.environ.get('SECRETE_KEY', default='dev')
)
app.config.from_pyfile('config.py', silent=True)

from views import *

from models import db
db.init_app(app)
migrate = Migrate(app, db)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)