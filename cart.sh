echo Setting NodeJS repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo Installing NodeJS
yum install nodejs -y &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

id roboshop &>>/tmp/cart.log
if [ $? -ne 0 ]; then
  echo Adding Application User
  useradd roboshop &>>/tmp/cart.log
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 1
  fi
fi


echo Downloading Application Content
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>/tmp/cart.log
cd /home/roboshop &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo Cleaning old application content
rm -rf cart &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo Extract Application Archive
unzip -o /tmp/cart.zip &>>/tmp/cart.log && mv cart-main cart &>>/tmp/cart.log && cd cart &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo Installing NodeJS Dependencies
npm install &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo Configuring Cart SystemD Service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log && systemctl daemon-reload &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi

echo Starting Cart Service
systemctl start cart &>>/tmp/cart.log && systemctl enable cart &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
  exit 1
fi


