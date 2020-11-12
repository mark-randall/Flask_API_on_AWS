import os
from flask import Flask, jsonify

app = Flask(__name__, instance_relative_config=True)
app.config.from_mapping(
    SECRET_KEY=os.environ.get('SECRETE_KEY', default='dev')
)
app.config.from_pyfile('config.py', silent=True)

@app.route('/')
def root():
    return jsonify('API coming soon!')

@app.route('/health')
def health():
    return jsonify('It is alive')

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=80)