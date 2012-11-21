#/usr/bin
#Filename:send_notifiation.sh
function send_notification
{
if [ -s $MAIL_FILE -a "$MAILOUT" = "TRUE" ]
then
	case $(uname) in 
	AIX|HP-Linux|OpenBSD) SENDMAIL="/usr/sbin/sendmail"
		;;
	SunOS) SENDMAIL="/usr/lib/sendmail"
		;;
	esac
	
	echo "\nSending email notification"
	$SENDMAIL -f 451248559@qq.com $MAIL_LIST > $MAIL_FILE
fi
}
