#!/system/bin/sh

sleep 5
if [ ! -f /data/set_time ];then
	date -s 20140101
	touch /data/set_time
fi
