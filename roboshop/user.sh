#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
MONGDB_HOST=mongodb.daws76s.fun

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
      echo "error $2 not instlled"
      exit 1
    else
       echo "$2 success"
    fi
}

if [ $ID -ne 0 ]
then 
    echo "error run with root user"
    exit 1
else
    echo "you are root user"
    fi

dnf module disable nodejs -y
VALIDATE $? "disable node js"
dnf module enable nodejs:18 -y
VALIDATE $? "enable nodejs"
dnf install nodejs -y
VALIDATE $? "nodejsinstallation"
useradd roboshop
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip
cd /app 
unzip /tmp/user.zip
npm install 
VALIDATE $? "npm install"
cp /home/centos/projectdevelopmentshell/user.service /etc/systemd/system/user.service
VALIDATE $? "copying"
systemctl daemon-reload
VALIDATE $? "reload"
systemctl enable user
VALIDATE $? "enable user"
systemctl start user
VALIDATE $? "start user"
cp /home/centos/projectdevelopmentshell/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y
VALIDATE $? "mongo instalation"
mongo --host $MONGDB_HOST </app/schema/user.js

