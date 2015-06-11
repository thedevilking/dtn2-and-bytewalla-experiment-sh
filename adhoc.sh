#!/bin/bash
usage(){
       	echo "usage: `basename $0` ip-addrs"
}
IP=$1
if [ $# -ne 1 ]; then
        usage
        exit 1
fi

del_adhoc0=0
del_wlan0=0
add_adhoc0=0
adhoc0_up=0
adhoc0_join=0

ifconfig adhoc0 $IP
if [ $? -eq 0 ];then
	iw dev adhoc0 del
	if [ $? -eq 0 ];then
		del_adhoc0=1
		echo "adhoc0 del done!"
	else
		exit 1;
	fi
fi

ifconfig wlan0 $IP
if [ $? -eq 0 ];then
	iw dev wlan0 del
	if [ $? -eq 0 ];then
		del_wlan0=1
		echo "wlan0 del done!"
	else
		exit 1;
	fi
fi

iw phy phy0 interface add adhoc0 type ibss
if [ $? -eq 0 ];then
	add_adhoc0=1
	echo "iw phy phy0 interface add adhoc0 done!"
else
	exit 1;
fi

if [ $add_adhoc0 -eq 1 ];then
	ifconfig adhoc0 up
	if [ $? -eq 0 ];then
		adhoc0_up=1
		echo "ifconfig adhoc0 up done!"
	else
		exit 1;
	fi
fi

if [ $adhoc0_up -eq 1 ];then
	iw dev adhoc0 ibss join edison 2412 02:11:87:6E:84:00
	if [ $? -eq 0 ];then
		adhoc0_join=1
		echo "iw dev adhoc0 ibss join done!"
	else
		exit 1;
	fi
fi

ifconfig adhoc0 $IP
ifconfig adhoc0

#route add default gw 192.168.5.1 dev adhoc0

echo "change iSerial"
echo -n med-$IP > /sys/class/android_usb/android0/iSerial
