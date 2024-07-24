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
       echo  " error $2 failed "
    else
        echo " $2 success "
    fi
}
if  [ $ID -ne 0 ]
then 
    echo -e "$R do with root user $N"
    exit 1
else
    echo -e "$G you are root user $N"
fi
dnf module disable nodejs -y
VALIDATE $? "disable nodejs "
dnf module enable nodejs:18 -y
VALIDATE $? "enable nodejs "
dnf install nodejs -y
VALIDATE $? "installing node js"
useradd roboshop
VALIDATE $? "useradding"
mkdir /app
VALIDATE $? "diradding"
curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip
cd /app 
unzip /tmp/catalogue.zip
VALIDATE $? "unzip "
cd /app
npm install 
VALIDATE $? "npm install"
cp /home/centos/projectdevelopmentshell/catalogue.service /etc/systemd/system/catalogue.service
VALIDATE $? "copy catalogue service"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
VALIDATE $? "starting catalogue"
cp /home/centos/projectdevelopmentshell/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y
VALIDATE $? "mongodb"
mongo --host $MONGDB_HOST </app/schema/catalogue.js
VALIDATE $? "load schema into mongo db"

