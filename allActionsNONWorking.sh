#!/bin/sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Jail Monitor service started at ${DATE}" | systemd-cat -p info
MONITORDIR="/jail/"

inotifywait -r -e create,delete,modify,move,attrib "${MONITORDIR}" |
while read OP NEWFILE
do
	#echo ${OP} ${NEWFILE}
	if [ "${OP}" == *"CREATE"* ]; then
		echo "CREATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created"
        #curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="CREATION ALERT ($(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created in ${MONITORDIR} by <strong>$(whoami)</strong> ::"
		echo "CREATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created" >> /var/log/iot/fs/tmp
	elif [ "${OP}" == *"DELETE"* ]; then 
		echo "DELETION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been deleted"
        #curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="DELETION ALERT ($(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created in ${MONITORDIR} by <strong>$(whoami)</strong> ::"
		echo "DELETION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created" >> /var/log/iot/fs/tmp
	elif [ "${OP}" == *"MODIFY"* ]; then
		echo "MODIFICATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been modified"
		echo "MODIFICATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created" >> /var/log/iot/fs/tmp
	elif [ "${OP}" == *"MOVE"* ]; then
		echo "MOVE[]RENAME - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been moved/renamed"
		echo "MOVE[]RENAME - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been moved/renamed" >> /var/log/iot/fs/tmp
	elif [ "${OP}" == *"ATTRIB"* ]; then
		echo "ATTRIBUTES - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} attributes have been modified"
		echo "ATTRIBUTES - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} attributes have been modified" >> /var/log/iot/fs/tmp
	fi
done

#!/bin/sh
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "Jail Monitor service started at ${DATE}" | systemd-cat -p info
MONITORDIR="/jail/"

while read inotifywait -r -e create,delete,modify,move,attrib "${MONITORDIR}";
do
	if [ "${OP}" == "CREATE" ]; then
		echo "CREATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created"
        #curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="CREATION ALERT ($(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created in ${MONITORDIR} by <strong>$(whoami)</strong> ::"
		echo "CREATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created" >> /var/log/iot/fs/tmp
	elif [ "${OP}" == "DELETE" ]; then 
		echo "DELETION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been deleted"
        #curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="DELETION ALERT ($(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created in ${MONITORDIR} by <strong>$(whoami)</strong> ::"
		echo "DELETION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created" >> /var/log/iot/fs/tmp
	elif [ "${OP}" == "MODIFY" ]; then
		echo "MODIFICATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been modified"
		echo "MODIFICATION - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been created" >> /var/log/iot/fs/tmp
	elif [ "${OP}" == "MOVE" ]; then
		echo "MOVE[]RENAME - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been moved/renamed"
		echo "MOVE[]RENAME - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} has been moved/renamed" >> /var/log/iot/fs/tmp
	elif [ "${OP}" == "ATTRIB" ]; then
		echo "ATTRIBUTES - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} attributes have been modified"
		echo "ATTRIBUTES - $(date '+%d/%m/%Y %H:%M:%S')): ${NEWFILE} attributes have been modified" >> /var/log/iot/fs/tmp
	fi
done
