from flask import Flask
import flask
import spacy
import os
import json
import logging

# Load in model
nlp = spacy.load('en_core_web_sm')
# If you plan to use a your own model artifacts,
# your model artifacts should be stored in /opt/ml/model/


# The flask app_local for serving predictions
app = Flask(__name__)


@app.route('/ping', methods=['GET'])
def ping():
    # Check if the classifier was loaded correctly
    health = nlp is not None
    status = 200 if health else 404
    return flask.Response(response='\n', status=status, mimetype='application/json')


@app.route('/invocations', methods=['POST'])
def transformation():
    # Process input
    input_json = flask.request.get_json()
    resp = input_json['input']

    #TODO: call private ai process_request
    # NER
    doc = nlp(resp)
    entities = [(X.text, X.label_) for X in doc.ents]

    # Transform predictions to JSON
    result = {
        'output': entities
    }

    resultjson = json.dumps(result)
    return flask.Response(response=resultjson, status=200, mimetype='application/json')