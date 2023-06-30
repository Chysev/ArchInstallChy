#!/bin/bash

echo -ne "
-------------------------------------------------------------------------
   _____  _                              
  / ____|| |                             
 | |     | |__   _   _  ___   ___ __   __
 | |     | '_ \ | | | |/ __| / _ \\ \ / /
 | |____ | | | || |_| |\__ \|  __/ \ V / 
  \_____||_| |_| \__, ||___/ \___|  \_/  
                  __/ |                  
                 |___/  
-------------------------------------------------------------------------                   
"
./ArchChyInstall/Initial.sh

./ArchChyInstall/setkey_font_date.sh

./ArchChyInstall/formatdisk.sh

./ArchChyInstall/mountpartition.sh

# Generate the fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Install essential packages
./ArchChyInstall/packages.sh

./ArchChyInstall/locale_clock_timezone.sh

# Set the hostname
read -p "Enter your hostname/devicename:" hostname 
hostnamectl set-hostname $hostname

# Generate the initramfs
mkinitcpio -P

# Set the root password
passwd

# Install and configure systemd-boot
bootctl install
bootctl --esp-path=/efi --boot-path=/boot install
bootctl update

echo -ne "You make now type exit or pressing Ctrl+d and dont forget to unmount /mnt by:"
echo -ne "umount -R /mnt"
echo -ne "Finally, restart the machine by typing reboot: any partitions still mounted will be automatically unmounted by systemd. Remember to remove the installation medium and then login into the new system with the root account."
