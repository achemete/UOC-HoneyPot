#!/bin/bash

CHROOT='/iot'
#mkdir $CHROOT

for i in $( ldd $* | grep -v dynamic | cut -d " " -f 3 | sed 's/://' | sort | uniq )
  do
    cp -vf --parents $i $CHROOT
  done

echo "Chroot jail is ready. To access it execute: chroot $CHROOT"