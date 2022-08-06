source common.sh

echo "Condifuring NodeJS YUM Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
StatusCheck

echo Installing NodeJS
yum install nodejs -y
StatusCheck


useradd roboshop

curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
cd /home/roboshop
rm -rf catalogue
unzip -o /tmp/catalogue.zip
mv catalogue-main catalogue
cd /home/roboshop/catalogue
npm install

mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl start catalogue
systemctl enable catalogue

