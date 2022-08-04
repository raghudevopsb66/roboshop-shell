set -e

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/cart.log 
yum install nodejs -y &>>/tmp/cart.log

useradd roboshop &>>/tmp/cart.log

curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/tmp/cart.log
cd /home/roboshop &>>/tmp/cart.log
rm -rf cart &>>/tmp/cart.log
unzip -o /tmp/cart.zip &>>/tmp/cart.log
mv cart-main cart &>>/tmp/cart.log
cd cart &>>/tmp/cart.log
npm install &>>/tmp/cart.log

mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log
systemctl daemon-reload &>>/tmp/cart.log
systemctl start cart &>>/tmp/cart.log
systemctl enable cart &>>/tmp/cart.log


