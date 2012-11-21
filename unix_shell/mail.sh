MAIL_FILE=/tmp/mailfile.out
cat /dev/null > $MAIL_FILE
MAIL_LIST="yuenqiin2012@gmail.com 451248559@qq.com"
check_filesystems
if [ -s $MAIL_FILE ]
then
	mail -s "Filesystem Full" $MAIL_LST > $MAIL_FILE
fi
