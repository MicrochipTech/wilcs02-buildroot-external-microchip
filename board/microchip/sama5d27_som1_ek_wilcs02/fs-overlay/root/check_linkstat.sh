#!/bin/bash

interface="wlan0"
check_interval=1
connect_state=0
blue_led=0

while true; do
    output=$(iw dev $interface link)

    if [[ $output == *"Connected"* ]]; then
	    connect_state=1
        #echo "WiFi connectivity on $interface is established."
    else
        connect_state=0
        #echo "WiFi connectivity on $interface is not established."
    fi

    if [[ $connect_state == 1 ]]; then
        echo 1 > /sys/class/leds/blue/brightness
        blue_led=1
    else
	if [[ $blue_led == 0 ]]; then
            echo 0 > /sys/class/leds/blue/brightness
            echo 1 > /sys/class/leds/blue/brightness
            blue_led=1
	else
            echo 0 > /sys/class/leds/blue/brightness
            blue_led=0
	fi    
    fi

    sleep $check_interval
done
