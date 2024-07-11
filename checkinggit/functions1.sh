#!/bin/bash
ID=$(id -u)
VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo "$2 failed "
        
    else
        echo "$2 success"
    fi
}

 if [ $ID  -ne  0  ]
then
    echo "go with root user"
    exit 1
    
else
    echo "you are root user"
fi
yum install mysq1 -y
VALIDATE $? "mysql install "

yum install git -y
VALIDATE