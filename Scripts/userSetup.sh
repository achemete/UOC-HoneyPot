#!/bin/bash

echo "Please, enter the username to add"
read new_user
home_path=/iot/home

echo "User to be added: $new_user"
useradd -G c $new_user
grep /etc/passwd -e "^$new_user" >> /iot/etc/passwd
passwd -d $new_user

cat /iot/etc/passwd

echo "Hit enter to continue"
read 

mkdir $home_path/$new_user
mkdir $home_path/$new_user/.bye
chmod -R 0700 $home_path/$new_user
chown -R $new_user:$new_user /$home_path/$new_user

chmod -R 0700 $home_path/$new_user/.bye
chown -R $new_user:$new_user /$home_path/$new_user/.bye

cp -R /iot/home/admin/.bashrc $home_path/$new_user
cp -R /iot/home/admin/.bash_profile $home_path/$new_user

ls -la $home_path/$new_user

echo "Hit enter to continue"
read 

echo -e "Match user $new_user\n\tPermitEmptyPasswords yes" >> /etc/ssh/sshd_config
systemctl restart sshd.service


echo "Work completed, jumping to the service creation"
echo "Hit enter to continue"
read 

path=/usr/bin


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

echo "Work completed, user ready to be monitored"
read 