#!/system/bin/sh
LOG_TAG="save-hcidump"
LOG_NAME="${0}:"

hcidump_pid=""

loge ()
{
  /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

failed ()
{
  loge "$1: exit code $2"
  exit $2
}

start_hcidump ()
{
      is_logcat_log_dir_exist=`ls /data/logcat_log/`
      if busybox test "$is_logcat_log_dir_exist"; then
          logi "sdcard logcat_log dir already exist"
      else
          logi "create data logcat_log dir"
          mkdir /data/logcat_log/
      fi

      #move hcidump.bin.1 to hcidump.bin.2, hcidump.bin to hcidump.bin.1
      is_btsnoop_hci1_exist=`ls /data/logcat_log/btsnoop_hci.log.1`
      if busybox test "$is_btsnoop_hci1_exist"; then
          logi "btsnoop_hci1 exists - copy to btsnoop_hci2"
          cp /data/logcat_log/btsnoop_hci.log.1 /data/logcat_log/btsnoop_hci.log.2
      fi

      is_btsnoop_hci_exist=`ls /data/logcat_log/btsnoop_hci.log`
      if busybox test "$is_btsnoop_hci_exist"; then
          logi "btsnoop_hci exists - copy to btsnoop_hci1"
          cp /data/logcat_log/btsnoop_hci.log /data/logcat_log/btsnoop_hci.log.1
          rm /data/logcat_log/btsnoop_hci.log
      fi
	  
      setprop debug.bluetooth.btsnoop true
      chmod 777 /data/logcat_log	   

      while true; do
      done

      hcidump_pid=$!
      logi "start_hcidump: pid = $hcidump_pid"
}

#fix BLUETOOTH_ENABLE to 1
BLUETOOTH_ENABLE="1"

case $BLUETOOTH_ENABLE in
    1)
        logi "try to start hcidump"
        start_hcidump

        wait $hcidump_pid
        logi "hcidump stopped"
     ;;
     *)
        logi "bluetooth not enabled"
        failed "bluetooth not enabled" -1
     ;;
esac

exit 0
