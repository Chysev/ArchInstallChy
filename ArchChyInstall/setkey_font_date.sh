#!/bin/bash

ls /usr/share/kbd/keymaps/**/*.map.gz

loadkeys us

setfont ter-132b

ls /sys/firmware/efi/efivars

timedatectl