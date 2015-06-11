#!/system/bin/sh
date -s "20150601.060000"
echo "clear dtn log"
sh /system/clear_dtnfile.sh
echo "init adhoc"
sh /system/adhoc.sh 192.168.5.11
sleep 1
echo "start dtn service"
sh /system/startdtn.sh

sleep 8

echo "send dtn message to 5.13 and 5.14"
dtnclient-pan -r "dtn://192.168.5.13.wu.com"
dtnclient-pan -s "dtn://192.168.5.14.wu.com"
