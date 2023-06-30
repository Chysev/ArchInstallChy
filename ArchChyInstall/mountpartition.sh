#!/bin/bash

if mount /dev/sdb2 /mnt; then
  echo "Mounted /dev/sdb2 to /mnt."
else
  echo "Failed to mount /dev/sdb2. Exiting..."
  exit 1
fi

if mkdir /mnt/boot; then
  echo "Created /mnt/boot directory."
else
  echo "Failed to create /mnt/boot directory. Exiting..."
  exit 1
fi

if mount /dev/sdb1 /mnt/boot; then
  echo "Mounted /dev/sdb1 to /mnt/boot."
else
  echo "Failed to mount /dev/sdb1 to /mnt/boot. Exiting..."
  exit 1
fi
