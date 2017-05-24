#!/usr/bin/env python
from flask import Flask, request

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello ' + request.remote_addr + '\n'

if __name__ == '__main__':
    app.run()
