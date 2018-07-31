#!/system/bin/sh
maxx_mode_switch=`getprop sys.config.maxxaudio`
echo maxxaudio "$maxx_mode_switch" > /proc/driver/audio_debug
