#The script assumes the following :
#1. Script it run after .github/workflows/nginx-deploy.yaml was run, meaning all repository content was copied.
#2. Destination EC2 instance is already configured as an Nginx web-server, no installations necessary.
#3. The script is statically typed, addressing Nginx configuration files with their default names (e.g. nginx.conf).

#Replace old nginx.conf with the new one
sudo mv nginx-config/nginx.conf /etc/nginx/nginx.conf
#Replace old conf.d/default.conf with the new one
sudo mv nginx-config/default.conf /etc/nginx/conf.d/default.conf

#Restart Nginx services, rebuild configuration.
sudo systemctl restart nginx
