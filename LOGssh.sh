#!/bin/sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "SSH Failed Login Monitor service started at ${DATE}" | systemd-cat -p info

MONITORDIR="/var/log/secure"
inotifywait -mre modify --exclude '.*?\.swp' --format 'Operation: %e - Path: %w%f' "${MONITORDIR}" | while read NEWFILE
do
	if [ tail -n 1 /var/log/secure | grep Accepted ]; then
		echo "Accepted"
	elif [ tail -n 1 /var/log/secure | grep Faileld ]; then
		echo "Failed"
	fi
	
    ##   echo "SSH LOGIN ATTEMPT - ${NEWFILE} - $(date '+%d/%m/%Y %H:%M:%S')): $(tail -n 1 /var/log/secure)"
    ##   #echo "SSH LOGIN ATTEMPT - ${NEWFILE} - $(date '+%d/%m/%Y %H:%M:%S')): $(grep 'Failed password' /var/log/secure | tail -n 1)"
    ##   curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="SSH LOGIN ATTEMPT - $(date '+%d/%m/%Y %H:%M:%S')): $(grep 'Failed password' /var/log/secure | tail -n 1)" | tee -a /var/log/iot/ssh/telegram/sshLogin-attempt-Telegram.log > /dev/null
    ##   echo "SSH LOGIN ATTEMPT - ${NEWFILE} - $(date '+%d/%m/%Y %H:%M:%S')): $(tail -n 1 /var/log/secure)" >> /var/log/iot/ssh/bulk_Failed-logins.log

done

