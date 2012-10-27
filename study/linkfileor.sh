#!/bin/bash
#filename:linkfileornot
FILENAME=
echo "Input file name: "
read FILENAME
if [ -f $FILENAME ]
then 
    if [ -L $FILENAME ]
    then 
    mv $FILENAME /opt
     else
    echo " $FILENAME is not a link file!"
   fi
else
echo "$FILENAME is not exist!"
fi
