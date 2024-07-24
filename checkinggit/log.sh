#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
#echo "$TIMESTAMP"
LOGFILE="/tmp/$0-$TIMESTAMP.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$R ERROR : $2  $N fail $N"
    else
        echo "$2 success"
    fi
}
if [ $ID -ne 0 ]
then 
    echo "proceed with root user"
    exit 1
else
    echo "you are root user welcome"
fi
    yum install mysql -y &>> $LOGFILE
    VALIDATE $? "my sql installation"
    yum install git -y &>> $LOGFILE
    VALIDATE $? "my git installation"