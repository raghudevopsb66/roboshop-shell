source common.sh
COMPONENT=mysql

echo Setup YUM Repo
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>${LOG}
StatusCheck

echo Install MySQL
yum install mysql-community-server -y &>>${LOG}
StatusCheck

echo Start MySQL Service
systemctl enable mysqld &>>${LOG} && systemctl start mysqld &>>${LOG}
StatusCheck

DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')

echo "alter user 'root'@'localhost' identified with mysql_native_password by '$MYSQL_PASSWORD';" | mysql --connect-expired-password -uroot -p${DEFAULT_PASSWORD}

exit 
echo "uninstall plugin validate_password;" | mysql -uroot -p$MYSQL_PASSWORD
#> uninstall plugin validate_password;

curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"

cd /tmp
unzip -o mysql.zip
cd mysql-main
mysql -u root -pRoboShop@1 <shipping.sql

