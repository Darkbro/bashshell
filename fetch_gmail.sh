#!/bin/bash
#filename:fetch_gmail.sh
username="yuenqiin2012"
password="112358fuck"
SHOW_COUNT=5
echo
curl -u $username:$password --silent "https://mail.google.com/mail/feed/atom" | \
tr -d '\n' | sed 's:</entry>:\n:g' | \
 sed 's/.*<title>\(.*\)<\/title.*<author><name>\([^<]*\)<\/name><email>\([^<]*\).*/Author: \2 [\3] \nSubject: \1\n/' | \
head -n $(( $SHOW_COUNT * 3))
