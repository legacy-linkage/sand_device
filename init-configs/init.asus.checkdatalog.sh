#!/system/bin/sh

is_datalog_exist=`ls /data | grep logcat_log`
startlog_flag=`getprop persist.asus.startlog`
version_type=`getprop ro.build.type`
check_factory_version=`getprop ro.asus.factory`

if test "$version_type" = "userdebug"; then
	if test "$check_factory_version" = "1"; then
		start mpdecision
	fi
fi 

if test -e /data/everbootup; then
	echo 1 > /data/everbootup
	startlog_flag=`getprop persist.asus.startlog`

	if test "$is_datalog_exist"; then
		chown system.system /data/logcat_log
		chmod 0775 /data/logcat_log
		if test "$startlog_flag" -eq 1;then
		echo 1 > /proc/asusklog
		setprop sys.config.klog 1
		start logcat
		start logcat-radio
		start logcat-events
		else
		echo 0 > /proc/asusklog
		setprop sys.config.klog 0
		stop logcat
		stop logcat-radio
		stop logcat-events
		fi
	fi        	
else
	setprop persist.asus.ramdump 1
	setprop persist.asus.autosavelogmtp 0
	if  test "$version_type" = "eng"; then
		setprop persist.asus.startlog 1
		setprop persist.asus.kernelmessage 7
	elif test "$version_type" = "userdebug"; then
			if test "$check_factory_version" = "1"; then
				setprop persist.asus.kernelmessage 7
				setprop persist.asus.enable_navbar 1
			else
				setprop persist.asus.kernelmessage 0	
			fi
		setprop persist.asus.startlog 1
		setprop persist.sys.downloadmode.enable 1
		
	fi
	
	startlog_flag=`getprop persist.asus.startlog`
	recheck_datalog=`ls /data | grep logcat_log`

	if test "$recheck_datalog"; then
		chown system.system /data/logcat_log
		chmod 0775 /data/logcat_log
		if test "$startlog_flag" -eq 1;then
		echo 1 > /proc/asusklog
		setprop sys.config.klog 1
		start logcat
		start logcat-radio
		start logcat-events
		else
		echo 0 > /proc/asusklog
		setprop sys.config.klog 0
		stop logcat
		stop logcat-radio
		stop logcat-events
		fi		
	fi
	echo 0 > /data/everbootup
fi
