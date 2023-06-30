#!/bin/bash

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Region/City /etc/localtime

hwclock --systohc

locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "KEYMAP=us" > /etc/vconsole.conf