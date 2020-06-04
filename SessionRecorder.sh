#!/bin/sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Session Recorder service started at ${DATE}" | systemd-cat -p info

safeguard=/var/log/iot/data/
MONITORDIR="/iot/home/"
inotifywait -m -e modify --exclude '.*?\.swp' --format '%w%f' "${MONITORDIR}" | while read NEWFILE
do
	#echo "hey, new file detected. $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created."
	if [[ "${NEWFILE}" == *"-session.log"* ]]; then
		cp ${NEWFILE} $safeguard
		echo "New Session recorded and saved $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created." >> /var/log/iot/data/log
		#echo "ATTB ALTERED - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE}  attributes have been altered to $(stat -c '%a' ${NEWFILE})" >> /var/log/iot/fs/attrib.log
		curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="Session recorded - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} saved in a safe place" > /dev/null
	fi
				   
done
