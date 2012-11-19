#usr/bin
set -x
RN=$(dd if=/dev/random  count=1 2>/dev/null | od -t u4 | awk '{print $2}' | head -n 1)
echo $RN
