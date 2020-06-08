#!/bin/bash
DATE=`date '+%Y-%m-%d %H:%M:%S'`
path=/usr/bin/
services=(logAttribute.service logCreate.service logDelete.service logListing.service logModify.service logMove.service logSSH.service sessionRecorder.service)
binaries=(LOGattribControl.sh LOGcreateControl.sh LOGdeleteControl.sh LOGlistingControl.sh LOGmodifyControl.sh LOGmoveControl.sh LOGssh.sh sessionRecorder.sh)

for service in "${services[@]}"; 
do
	systemctl enable $service
	echo "$service enabled on the $DATE" 
	systemctl start $service
	echo "$service started on the $DATE" 
done

for bin in "${binaries[@]}"; 
do
	chmod 755 $path$bin
	echo "Permissions of $bin have been updated on the $DATE" 
done

