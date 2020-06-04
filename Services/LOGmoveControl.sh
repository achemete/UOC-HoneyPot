#!/bin/sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Jail Move/Rename Monitor service started at ${DATE}" | systemd-cat -p info
opid=0
itsone=1

MONITORDIR="/iot/"
inotifywait -m -r -e move --exclude '.*?\.swp' --format '%w%f' "${MONITORDIR}" | while read NEWFILE
do
		#opreal=`expr $opid - $itsone`
        echo "RNMD/MVD - $(date '+%d/%m/%Y %H:%M:%S')): OPID: $opid ${NEWFILE} has been renamed/moved." #| tee -a /var/log/iot/fs/rnmdmvd.log
		#curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="RNMD/MVD - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been renamed/moved." | tee -a /var/log/iot/fs/telegram/renameTelegram.log > /dev/null
        echo "RNMD/MVD - $(date '+%d/%m/%Y %H:%M:%S')): OPID: $opid ${NEWFILE} has been renamed/moved." >> /var/log/iot/fs/rnmdmvd.log
		((opid++))
done

