#!/bin/bash
set -x 
#ssh_login(){
#expect -c "spawn ssh root@$ip
#          expect \"*password:\"
#          send \"$password\r\"
#          send \"mkdir -p teste\r\"
#          expect eof"
#}
#ssh_login
#set -x

cat ippass.txt | while read LINE  USER PASS
                do

cat  << EOF  > ssh.exp  
#!/usr/bin/expect 
 set PASS {lindex argv1}
 
 spawn ssh root@$LINE
 expect \"*password:\"
 send \"$PASS\r\"
 send \"mkdir -p teste\r\"
 expect eof
EOF
#ssh_login
chmod o+x ssh.exp
expect ssh.exp



sleep 3




#ippass=$LINE
#ip=`echo $ippass | cut -d' ' -f 1`
#password=`echo $ippass | cut -d' ' -f 3`
done
