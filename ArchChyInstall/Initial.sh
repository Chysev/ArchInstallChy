#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

ping -q -c 1 google.com >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "No internet connection. Please connect first before running the script"
  exit 1
fi

