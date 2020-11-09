# import os
# from flask import Flask, jsonify

# def create_app(test_config=None):
# 	app = Flask(__name__, instance_relative_config=True)
# 	app.config.from_mapping(
# 		SECRET_KEY=os.environ.get('SECRETE_KEY', default='dev')
# 	)

# 	if test_config is None:
# 		app.config.from_pyfile('config.py', silent=True)
# 	else:
# 		app.config.from_mapping(test_config)

# 	@app.route('/health')
# 	def health():
# 		return jsonify('It is alive')

# 	return app

