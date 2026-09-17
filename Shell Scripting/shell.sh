#!/bin/bash

date=$(date)
user=$(whoami)
hostname=$(hostnamectl)
disk=$(df)
process=$(ps > touch process.txt)

echo "User : $user"
echo "Date : $date"
echo "hostname : $hostname"
echo "disk : $disk"
echo "All process stored in process.txt!"