source common.sh

COMPONENT=cart
NODEJS

echo Configuring Cart SystemD Service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log && systemctl daemon-reload &>>/tmp/cart.log
StatusCheck

echo Starting Cart Service
systemctl start cart &>>/tmp/cart.log && systemctl enable cart &>>/tmp/cart.log
StatusCheck


