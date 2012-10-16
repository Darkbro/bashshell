printf "Enter new password: "
stty -echo
read pass < /dev/tty
printf "Enter again: "
read pass2 < /dev/tty
stty echo

