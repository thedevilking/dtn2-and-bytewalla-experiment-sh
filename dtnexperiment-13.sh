#!/system/bin/sh
date -s "20150601.060000"
echo "clear dtn log"
sh /system/clear_dtnfile.sh
echo "init adhoc"
sh /system/adhoc.sh 192.168.5.13
sleep 1
echo "start dtn service"
sh /system/startdtn.sh

