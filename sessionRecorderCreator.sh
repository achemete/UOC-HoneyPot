#!/bin/bash

path=/usr/bin

echo "Please, write the username"
read new_user

filename="exit-$new_user"
sh=".sh"

cp $path/exit-generic.sh $path/$filename$sh

find $path/$filename$sh -type f -exec sed -i "s/user/$new_user/g" {} \;

chmod 755 $path/$filename$sh
ls -ltr $path/$filename$sh

echo "Hit enter to continue"
read 

systemctl enable $filename.service
systemctl start $filename.service

echo "Work completed."
read 


/usr/bin/sessionRecorder-generic.sh