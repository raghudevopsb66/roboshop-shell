#!/usr/bin/bash

# RoboShop - Frontend Setup

COMPONENT=frontend
source common.sh

echo Installing Nginx
yum install nginx -y &>>${LOG}
StatusCheck

DOWNLOAD

echo Clean Old Content
cd /usr/share/nginx/html && rm -rf *
StatusCheck

echo Extract Downloaded Content
unzip -o /tmp/frontend.zip &>>${LOG} && mv frontend-main/static/* . &&  mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
StatusCheck

echo Updating Nginx Configuration
sed -i -e '/catalogue/ s/localhost/catalogue-dev.roboshop.internal/' -e '/cart/ s/localhost/cart-dev.roboshop.internal/' -e '/user/ s/localhost/user-dev.roboshop.internal/' -e '/shipping/ s/localhost/shipping-dev.roboshop.internal/' -e '/payment/ s/localhost/payment-dev.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
StatusCheck

echo Start Nginx Service
systemctl restart nginx &>>${LOG} && systemctl enable nginx &>>${LOG}
StatusCheck