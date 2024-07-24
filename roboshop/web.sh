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
        echo -e "$R ERROR  $2 failed$N"
        exit 1
    else
        echo -e "$G $2 success$N"
    fi
}
if [ $ID -ne 0 ]
then 
    echo -e "$R run with sudo access"
    exit 1
else 
    echo -e " $G you are root user$N"
fi
dnf install nginx -y
VALIDATE $? "nginx install"
systemctl enable nginx
VALIDATE $? "enableing nginx "
systemctl start nginx
VALIDATE $? "starting nginx"
rm -rf /usr/share/nginx/html/*
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip
cd /usr/share/nginx/html
unzip /tmp/web.zip
cp /home/centos/projectdevelopmentshell/roboshop.conf /etc/nginx/default.d/roboshop.conf 
systemctl restart nginx 
VALIDATE $? "restart status is "


