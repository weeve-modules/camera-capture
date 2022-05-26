import logging
from logging import basicConfig, DEBUG
from flask import Flask, render_template, request
from werkzeug.utils import secure_filename
app = Flask(__name__,)
basicConfig(
    level=DEBUG, format='➡️  %(levelname)s : %(asctime)s : %(name)s  :  %(message)s')


@app.route('/', methods=['POST', 'GET'])
def upload():
    if request.method == 'POST':
        try:
            f = request.files['image']
            logging.info(f.filename)
            f.save(secure_filename(f.filename))
            return "File saved successfully"
        except Exception as e:
            logging.error(e)
            return "Something went wrong"

    else:
        return "Nope"


app.run(host='0.0.0.0', port=5000)
