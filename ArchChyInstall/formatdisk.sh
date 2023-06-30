#!/bin/bash

read -p "Enter the disk device name (e.g., /dev/sda): " disk

if [[ ! -e $disk ]]; then
  echo "Disk $disk does not exist."
  exit 1
fi

if [[ $(lsblk -no PARTUUID $disk) ]]; then
  echo "Disk $disk has a partition. Deleting the partition..."

  if sfdisk --delete $disk; then
    echo "Partition on $disk deleted successfully."
  else
    echo "Failed to delete the partition on $disk. Exiting..."
    exit 1
  fi
else
  echo "Disk $disk does not have any partitions."
fi

parted -s $disk mklabel gpt
parted -s $disk mkpart primary fat32 1MiB 1001MiB
parted -s $disk set 1 boot on
parted -s $disk mkpart primary ext4 1001MiB 100%

if [[ $? -ne 0 ]]; then
  echo "Failed to create partitions on $disk."
  exit 1
fi

mkfs.fat -F32 -n "EFI system" ${disk}1

if [[ $? -ne 0 ]]; then
  echo "Failed to format partition 1 as EFI system."
  exit 1
fi

mkfs.ext4 -L "Root" ${disk}2

if [[ $? -ne 0 ]]; then
  echo "Failed to format partition 2 as ext4."
  exit 1
fi

echo "Partitions created and formatted successfully on $disk."
