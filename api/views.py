from flask import jsonify, request, abort
from markupsafe import escape
from main import app
from models import db, User, Activity, UserActivity

@app.route('/')
def root():
    return jsonify('API coming soon!')

@app.route('/health')
def health():
    return jsonify('It is alive')

# Users

@app.route('/users', defaults={'user_id': None}, methods=['POST'])
@app.route('/users/<string:user_id>', methods=['PUT', 'GET'])
def users(user_id):

    if request.method == 'POST':
        return 'TODO: POST %s' % escape(user_id)
    elif request.method == 'GET':
        return 'TODO: GET %s' % escape(user_id)

# Activities

@app.route('/activities', defaults={'activity_id': None}, methods=['POST'])
@app.route('/activities/<int:activity_id>', methods=['PUT', 'GET'])
def activities(activity_id):

    if request.method == 'POST':

        # validate parameters
        json = request.json
        if 'name' not in json:
            abort(400)

        # insert
        try:
            activity = Activity(name=json['name'])
            db.session.add(activity)
            db.session.commit()
            return ('', 201)
        except:
            abort(400)

    elif request.method == 'GET':
        return 'TODO: GET %s' % escape(activity_id)