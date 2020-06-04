#!/bin/bash
DATE=`date '+%Y-%m-%d %H:%M:%S'`
services=(logAttribute.service logCreate.service logDelete.service logListing.service logModify.service logMove.service logSSH.service adminExit.service sessionRecorder.service userExit.service testExit.service)
for service in "${services[@]}"; 
do
	systemctl restart $service
	echo "$service restarted on the $DATE" >> "/var/log/iot/services/`date '+%b_%d'`-servicesRestart.log"
done
curl -s -X POST https://api.telegram.org/bot"1295844392:AAFU2iimLgQSYYzqulyQFMh_WDzYx8mDNrM"/sendMessage -d chat_id="-1001432405442" -d parse_mode='html' -d text="LOG SERVICES RESTARTED - $(date '+%d/%m/%Y %H:%M:%S')" | tee -a /var/log/iot/services/telegram/servicesRestart.log > /dev/null
