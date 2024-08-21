#!/bin/sh

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"


warningLevel=80
energy=$(cat /sys/class/power_supply/BAT0/capacity) #or acpi -b | grep -P -o '[0-9]+(?=%)' for battery level
discharging=$(acpi -b | grep -c "Discharging")

#Use file to store whether we've shown a notification or not (to prevent multiple notifications)
FULL_FILE=/tmp/batteryfull

#Reset notification if the computer is charging/discharging
if [[ $discharging -eq 1 ]] && [[ -f $FULL_FILE ]]; then
    rm $FULL_FILE
fi

if [[ energy -ge warningLevel ]] && [[ $discharging -eq 0 ]] && [[ ! -f $FULL_FILE ]] #To prevent multiple notification during both charging and discharging
then
	echo "beep booop"
    notify-send "High Battery" "Battery energy above 80%. Unplug it this instance." -u critical -i "battery-alert" -r 9991 -a "Battery police"
    touch $FULL_FILE
fi
