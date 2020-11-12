import os
from flask import Flask, jsonify
from flask_migrate import Migrate
from utils import *

# Get secrets from AWS Secret Manager
secrets = AWSSecretManagerValues(secret_name=os.environ.get('AWS_SECRETE_MANAGER_SECRET_NAME'), region=os.environ.get('AWS_REGION'))
database_url = f"{secrets['engine']}://{secrets['username']}:{secrets['password']}@{secrets['host']}:{secrets['port']}/{secrets['dbname']}"

# Create Flask app
app = Flask(__name__, instance_relative_config=True)
app.config.from_mapping(
    SECRET_KEY=os.environ.get('SECRETE_KEY', default='dev'),
    SQLALCHEMY_DATABASE_URI=database_url
)
app.config.from_pyfile('config.py', silent=True)

# Import views
from views import *

# Import models
from models import db
db.init_app(app)
migrate = Migrate(app, db)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)