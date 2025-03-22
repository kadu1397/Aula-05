from flask import Flask
import socket

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, World!"

if __name__ == '__main__':
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    print(f"Server IP Address: {ip_address}")
    app.run(host='0.0.0.0', port=8000)