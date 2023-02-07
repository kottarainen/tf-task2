#!/bin/bash
sudo apt update -y 
sudo apt upgrade -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo echo '<h1>Nginx server is working</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(176, 224, 230);"> <h1>Nginx server</h1> <p>Practice task 2</p> </body></html>' | sudo tee /var/www/html/app1/index.html
