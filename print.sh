#!/bin/bash
NUMBER=1
for number in $NUMBER
do 
if [ $number -ge 1000 ]
then 
   num=$number
    echo -e  $num
    
    number=($num)+1
    

fi
done 
