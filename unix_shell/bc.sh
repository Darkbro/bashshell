#!/bin/bash 
set -x 
for number in 2.3 5.6 8.9 
do 	
ADD="$ADD $PLUS $number"	
PLUS="+"
done
SUM=`bc <<EOF
(${ADD})
EOF`
echo $SUM
