set -e

echo Setting NodeJS repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/cart.log
echo $?

echo Installing NodeJS
yum install nodejs -y &>>/tmp/cart.log
echo $?

echo Adding Application User
useradd roboshop &>>/tmp/cart.log
echo $?

echo Downloading Application Content
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/tmp/cart.log
cd /home/roboshop &>>/tmp/cart.log
echo $?

echo Cleaning old application content
rm -rf cart &>>/tmp/cart.log
echo $?

echo Extract Application Archive
unzip -o /tmp/cart.zip &>>/tmp/cart.log
mv cart-main cart &>>/tmp/cart.log
cd cart &>>/tmp/cart.log
echo $?

echo Installing NodeJS Dependencies
npm install &>>/tmp/cart.log
echo $?

echo Configuring Cart SystemD Service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log
systemctl daemon-reload &>>/tmp/cart.log
echo $?

echo Starting Cart Service
systemctl start cart &>>/tmp/cart.log
systemctl enable cart &>>/tmp/cart.log
echo $? 

