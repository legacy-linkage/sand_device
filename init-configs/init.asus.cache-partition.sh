#!/system/bin/sh

LOG_TAG="cache_partition"
LOG_NAME="${0}:"

logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}



if [ -e "/dev/block/platform/msm_sdcc.1/by-name/APD" ]; then
	logi " : has APD partition"
	setprop sys.asus.ota.partition 1
else
	if [ -e "/dev/block/platform/msm_sdcc.1/by-name/demoapp" ]; then
		logi " : has demoapp partition"
		setprop sys.asus.ota.partition 1
	else
		logi " : has no APD or demoapp partition"
		setprop sys.asus.ota.partition 2
	fi
fi
