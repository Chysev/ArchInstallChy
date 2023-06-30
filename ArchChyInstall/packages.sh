#!/bin/bash

echo "Server = https://mirror.rackspace.com/archlinux/\$repo/os/\$arch" | sudo tee -a /mnt/etc/pacman.d/mirrorlist > /dev/null
pacstrap -K /mnt base linux linux-firmware nano NetworkManager