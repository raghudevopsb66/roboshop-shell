# this script is only for DRY.

StatusCheck() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 1
  fi
}

NODEJS() {
  echo Setting NodeJS repos
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/${COMPONENT}.log
  StatusCheck

  echo Installing NodeJS
  yum install nodejs -y &>>/tmp/${COMPONENT}.log
  StatusCheck

  id roboshop &>>/tmp/${COMPONENT}.log
  if [ $? -ne 0 ]; then
    echo Adding Application User
    useradd roboshop &>>/tmp/${COMPONENT}.log
    StatusCheck
  fi
  
  echo Downloading Application Content
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>/tmp/${COMPONENT}.log
  cd /home/roboshop &>>/tmp/${COMPONENT}.log
  StatusCheck
  
  echo Cleaning old application content
  rm -rf ${COMPONENT} &>>/tmp/${COMPONENT}.log
  StatusCheck
  
  echo Extract Application Archive
  unzip -o /tmp/${COMPONENT}.zip &>>/tmp/${COMPONENT}.log && mv ${COMPONENT}-main ${COMPONENT} &>>/tmp/${COMPONENT}.log && cd ${COMPONENT} &>>/tmp/${COMPONENT}.log
  StatusCheck
  
  echo Installing NodeJS Dependencies
  npm install &>>/tmp/${COMPONENT}.log
  StatusCheck
  
  echo Configuring ${COMPONENT} SystemD Service
  mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>/tmp/${COMPONENT}.log && systemctl daemon-reload &>>/tmp/${COMPONENT}.log
  StatusCheck

  echo Starting ${COMPONENT} Service
  systemctl start ${COMPONENT} &>>/tmp/${COMPONENT}.log && systemctl enable ${COMPONENT} &>>/tmp/${COMPONENT}.log
  StatusCheck
}