#!/bin/bash

echo "Starting script execution..."

# Update package index and install prerequisites
echo "Updating package index..."
sudo yum update -y && echo "Package index updated."

# Install Docker
sudo yum install docker && echo "Docker Installed"
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose && echo "Docker compose Installed"

# Enable and start Docker
echo "Enabling Docker service..."
sudo systemctl enable docker && echo "Docker service enabled."

echo "Starting Docker service..."
sudo systemctl start docker && echo "Docker service started."

# Install Nginx
echo "Installing Nginx..."
sudo yum install -y nginx && echo "Nginx installed."

# Enable and start Nginx
echo "Enabling Nginx service..."
sudo systemctl enable nginx && echo "Nginx service enabled."

echo "Starting Nginx service..."
sudo systemctl start nginx && echo "Nginx service started."

# Install Certbot
echo "Installing Certbot and python3-certbot-nginx..."
sudo yum install -y certbot python3-certbot-nginx && echo "Certbot and python3-certbot-nginx installed."

# (Optional) Setup Docker to run without sudo
echo "Adding $USER to docker group..."
sudo usermod -aG docker $USER && echo "$USER added to docker group."

# Print Docker, Nginx, and Certbot versions to verify installation
echo "Verifying Docker installation..."
docker --version && echo "Docker installed successfully."

echo "Verifying Nginx installation..."
nginx -v && echo "Nginx installed successfully."

echo "Verifying Certbot installation..."
certbot --version && echo "Certbot installed successfully."

echo "Verifying docker compose installation..."
docker-compose version && "Docker compose installed successfully."
echo "Script execution completed."

