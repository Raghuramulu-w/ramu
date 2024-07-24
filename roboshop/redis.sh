#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
Timestamp=$(date +%F-%H-%M-%S)
VALIDATE(){
    if [ $1 -ne 0 ]
     then
        echo -e "$R  $2 failed"
      else
        echo -e "$G $2 success"
    fi  
}
#checking root user or not
if [ $ID -ne 0 ]
 then 
    echo -e "$R ERROR do with root user"
    exit 1
else 
    echo -e "$G you are root user"
fi
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
VALIDATE $? "remi-release"
dnf module enable redis:remi-6.2 -y
VALIDATE $? "redisenable"
dnf install redis -y
VALIDATE $? "redis instalation "

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf
VALIDATE $? "remote update"
systemctl enable redis
VALIDATE $? "enabling redis"
systemctl start redis
VALIDATE $? "start redis success"