#!/usr/bin/sudo /bin/bash
echo "necessary setup work"
modprobe -r iwldvm iwlwifi mac80211 cfg80211
modprobe iwlwifi connector_log=0x1
# Setup monitor mode, loop until it works
echo "trying to setup monitor mode"
iwconfig wlan1 mode monitor 2>/dev/null 1>/dev/null
while [ $? -ne 0 ]
do
	iwconfig wlan1 mode monitor 2>/dev/null 1>/dev/null
done


echo "set channel $1 & $2"
iw wlan1 set channel $1 $2

echo "successfully set the adapter"
ifconfig wlan1 up
