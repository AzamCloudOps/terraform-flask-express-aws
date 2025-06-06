#!/bin/bash
set -e

# Update and install packages
apt update -y
apt upgrade -y
apt install -y git python3 python3-pip python3-venv nginx

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# App directory
mkdir -p /opt/devapps
cd /opt/devapps

# Clone Flask backend
git clone https://github.com/AzamCloudOps/flask-backend.git backend
cd backend

# Setup virtual environment
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# Run Flask app (port 5000)
nohup ./venv/bin/python3 app.py > /opt/devapps/flask.log 2>&1 &

# Nginx Reverse Proxy
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;

    location /api {
        proxy_pass http://localhost:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

chmod 644 /etc/nginx/sites-available/default
systemctl restart nginx
