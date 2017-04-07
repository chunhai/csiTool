#!/usr/bin/sudo /bin/bash
echo "necessary setup work"
sudo ifdown --exclude=lo -a && sudo ifup --exclude=lo -a
modprobe -r iwldvm iwlwifi mac80211 cfg80211
modprobe iwlwifi connector_log=0x1
sleep 1
# Setup monitor mode, loop until it works
echo "trying to setup monitor mode"
iwconfig wlan1 mode monitor 2>/dev/null 1>/dev/null
while [ $? -ne 0 ]
do
	iwconfig wlan1 mode monitor 2>/dev/null 1>/dev/null
done

echo "open the network"
ifconfig wlan1 up

echo "set channel $1 & $2"
iw wlan1 set channel $1 $2

echo "successfully set the adapter"
#ifconfig wlan1 up
