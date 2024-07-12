#!/bin/bash
ID=&(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
Timestamp=$(date +%F-%H-%M-%S)
VALIDATION(){
    if [ $1 -ne 0 ]
     then
        echo "$R  $2 failed"
      else
        echo "$G $2 success"
    fi  
}
#checking root user or not
if [ $ID -ne 0 ]
 then 
    echo "$R ERROR do with root user"
    exit 1
else 
    echo "$G you are root user"
fi
cp mongo.repo /etc/yum.repo.d
VALIDATE $? "MONGO COPYING"
dnf install mongodb-org -y 
VALIDATE $? "mongodbinstall"
systemctl enable mongod
VALIDATE $? "enabling mongodb"
systemctl restart mongod
VALIDATE $? "reatarting mongod"