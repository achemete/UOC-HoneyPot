#!/bin/bash

DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Terminal Killer for remote sessions started at ${DATE}" | systemd-cat -p info

safeguard=/var/log/iot/data
MONITORDIR="/iot/home/test/.bye"
inotifywait -m -e modify --exclude '.*?\.swp' --format '%w%f' "${MONITORDIR}" | while read NEWFILE
do
	#echo "parsing...:"
	#pts=$(who | awk '$1 ~ /^admin/{print $2}')
	while true;
	do		
		pts=$(who | awk '$1 ~ /^test/{print $2}' 2>&1)
		echo "$pts"
		if [ -n "$pts" ]; then
			echo "detected $pts"
			pkill -t $pts #$(who | awk '$1 ~ /^admin/{print $2}')
			echo "User test killed on $DATE from $pts" >> $safeguard/tty.log
		else
			break
		fi
	done
done
