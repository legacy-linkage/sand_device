#!/system/bin/sh
# ASUS Audio debug script tyree_liu@asus.com
audbg_mode=`getprop persist.asus.audbg`
echo "$audbg_mode" > /proc/driver/audio_debug
if [ "$audbg_mode" == "0" ];then
		setprop sys.config.uartlog 0		
else
		setprop sys.config.uartlog 1
fi
