source common.sh

COMPONENT=mongodb

echo Setup YUM repo
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${LOG}
StatusCheck

echo Install MongoDB
yum install -y mongodb-org  &>>${LOG}
StatusCheck

echo Start MongoDB Service
systemctl enable mongod &>>${LOG} && systemctl start mongod &>>${LOG}
StatusCheck

## Update the Listen config

DOWNLOAD

echo "Extract Schema Files"
cd /tmp && unzip -o mongodb.zip &>>${LOG}
StatusCheck

echo Load Schema
cd mongodb-main && mongo < catalogue.js &>>${LOG} && mongo < users.js &>>${LOG}
StatusCheck
