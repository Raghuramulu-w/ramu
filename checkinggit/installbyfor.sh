#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date +%F-%H-%S-%M)
LOGFILE="/tmp/$0-$TIMESTAMP.log"
VALIDATE(){
  if [ $1 -ne 0 ]
  then 
    echo -e " $R ERROR $2 failed "
  else
    echo -e " $2 is $G success  "
  fi
}
if [ $ID -ne 0 ]
    then 
      echo "do with root user"
      exit 1
    else 
      echo -e "$G you are root user"
fi
for package in $@
do
    yum list installed $package &>> $LOGFILE
    if [ $? -ne 0 ]
     then 
     yum install $package &>> $LOGFILE
     VALIDATE $? "MY INSTALLATION $package  "
     else
     echo -e " $Y $package is already installed  SKIPPING" 
     #VALIDATE $? "my installation $package "
     fi
done


