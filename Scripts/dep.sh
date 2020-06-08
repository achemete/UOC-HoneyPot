#!/bin/bash

CHROOT='/iot'
#mkdir $CHROOT

for i in $( ldd $* | grep -v dynamic | cut -d " " -f 3 | sed 's/://' | sort | uniq )
  do
    cp -vf --parents $i $CHROOT
  done

echo "Dependencies for chroot directory $CHROOT have been added."