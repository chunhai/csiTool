#!/usr/bin/sudo /bin/bash
modprobe -r iwldvm iwlwifi mac80211 cfg80211
modprobe iwlwifi debug=0x40000
ifconfig wlan0 2>/dev/null 1>/dev/null
while [ $? -ne 0 ]
do
	        ifconfig wlan0 2>/dev/null 1>/dev/null
done
iw dev wlan0 interface add mon0 type monitor
echo "open the adapter"
ifconfig mon0 up
sleep 1

iw mon0 set channel $1 $2
#iw dev mon0 set channel $channel_number $channel_type
    channel_set=$?
    while [ $channel_set -ne 0 ]
 do
        ip link set wlan0 down 2>/dev/null 1>/dev/null
        iw dev wlan0 set type monitor 2>/dev/null 1>/dev/null
        ip link set wlan0 up
        iw dev mon0 set channel $1 $2
        channel_set=$?
        if [ $channel_set -eq 0 ]; then
            echo "Fixed problem with set channel command............."
        fi
done
echo "sucessfully configure the adapter"
#ifconfig mon0 up
