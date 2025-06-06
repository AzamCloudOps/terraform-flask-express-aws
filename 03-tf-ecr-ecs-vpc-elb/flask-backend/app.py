from flask import Flask, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/submit', methods=['POST'])
def receive_feedback():
    data = request.get_json()
    if not data:
        return {'status': 'error', 'message': 'No JSON received'}, 400

    name = data.get('name')
    email = data.get('email')
    message = data.get('message')

    print(f"📩 Feedback received from {name} ({email}): {message}")
    return {'status': 'success'}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
