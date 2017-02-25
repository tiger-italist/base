from flask import Flask
from playhouse.flask_utils import FlaskDB

from config.server import ItalistConfig


app = Flask(__name__)
app.config.from_object(ItalistConfig)

db = FlaskDB(app)


@app.route('/')
def index():
    return "<span style='color:red'>To be or not to be.</span>"
