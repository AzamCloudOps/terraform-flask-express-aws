#!/bin/bash
set -e

# Update and install packages
apt update -y
apt upgrade -y
apt install -y git nginx curl

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# App directory
mkdir -p /opt/devapps
cd /opt/devapps

# Clone Express frontend
git clone https://github.com/AzamCloudOps/express-frontend.git frontend
cd frontend

# Install dependencies
npm install

# Run Express app (port 3000)
nohup npm start > /opt/devapps/express.log 2>&1 &

# Nginx Reverse Proxy
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
}
EOF

chmod 644 /etc/nginx/sites-available/default
systemctl restart nginx
