#!/bin/bash
set -e

# Update and install required packages
apt update -y
apt upgrade -y
apt install -y git python3 python3-pip python3-venv nginx curl

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Create base app directory with permissions
mkdir -p /opt/devapps
chown -R ubuntu:ubuntu /opt/devapps
chmod -R 755 /opt/devapps
cd /opt/devapps

# --- Flask App Setup ---
git clone https://github.com/AzamCloudOps/flask-backend.git backend
cd backend

python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# Run Flask backend (port 5000)
nohup ./venv/bin/python3 app.py > /opt/devapps/flask.log 2>&1 &

# --- Express App Setup ---
cd /opt/devapps
git clone https://github.com/AzamCloudOps/express-frontend.git frontend
cd frontend

npm install

# Run Express frontend (port 3000)
nohup npm start > /opt/devapps/express.log 2>&1 &

# --- Nginx Reverse Proxy ---
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }

    location /api {
        proxy_pass http://localhost:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

# Set proper permissions for Nginx config
chmod 644 /etc/nginx/sites-available/default

# Restart Nginx to apply new config
systemctl restart nginx



