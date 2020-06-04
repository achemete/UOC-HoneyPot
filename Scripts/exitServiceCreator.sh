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


echo "Service created, unit creation comes next."
read 

path_unit=/lib/systemd/system
filename_unit="exit-$new_user.service"

echo -e "[Unit]" >> $path_unit/$filename_unit
echo -e "Description=Jail $new_user Exit Monitor service.\n\n" >> $path_unit/$filename_unit

echo -e "[Service]" >> $path_unit/$filename_unit
echo -e "Type=simple" >> $path_unit/$filename_unit
echo -e "ExecStart=/bin/bash /usr/bin/exit-$new_user.sh\n\n" >> $path_unit/$filename_unit

echo -e "[Install]" >> $path_unit/$filename_unit
echo -e "WantedBy=multi-user.target" >> $path_unit/$filename_unit

echo "Unit created, enabling and starting service."
read 

systemctl enable $filename.service
systemctl start $filename.service

echo "Work completed, run exitCreator.sh"
read 