#!/bin/bash
# VARIABLES (Not yet coded for)
#
# ENC_DEVICE=$1
# MOUNT_POINT=$2
# IP=$3
# PORT=$4
#
#### AUTO MOUNT ENCRYPTED VOLUME ####
echo "Sending Keyfile"
echo "..."
scp -q -P $PORT keyfile $IP:/home
echo ""
echo "Opening Encrypted Volume"
echo "..."
ssh -q -t -p$PORT $IP "sudo chmod 600 /home/keyfile"
ssh -q -t -p$PORT $IP "sudo cryptsetup luksOpen /dev/xvdc encrypted --key-file /home/keyfile"
echo ""
echo "Removing Keyfile"
echo "..."
echo ""
ssh -q -t -p$PORT $IP "sudo rm -f keyfile"
echo "Mounting Encrypted Volume"
echo "..."
ssh -q -t -p$PORT $IP "sudo mount /dev/mapper/encrypted /mnt/encrypted/"
echo ""
echo "Running Rsync"
echo "..."
#### RUNNING SYNC ####
rsync -e 'ssh -p $PORT' -aruvhq /home $IP:/mnt/encrypted/data | pv
#### UNMOUNT AND ENCRYPT VOLUME ####
echo ""
echo "Rsync Complete"
echo "..."
echo ""
echo "Unmounting Volume"
echo "..."
ssh -q -t -p$PORT $IP "sudo umount /mnt/encrypted/"
echo ""
echo "Encrypting Volume"
echo "..."
ssh -q -t -p$PORT $IP "sudo cryptsetup luksClose encrypted"
echo ""
echo "Completed"
