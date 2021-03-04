#!/usr/bin/env bash

# define list of mobile devices
declare -A phone_list
phone_list[192.168.0.80]=6c:4d:73:f0:9d:b8 # iPhone 1
phone_list[192.168.0.81]=54:33:cb:7f:e5:0f # iPhone 2
# add list items as necessary

# define log location
log_location="home_mode_manager.log"

# define Synology API parameters
api_target="192.168.0.5:5000"
account="api_user"
password="<redacted>"
sid=$(curl -s "http://$api_target/webapi/auth.cgi?api=SYNO.API.Auth&method=Login&version=3&account=$account&passwd=$password&session=SurveillanceStation&format=sid" | jq .data.sid)

while true; do
  if [[ "$(date +%H:%M)" > "04:59" ]] && [[ "$(date +%H:%M)" < "21:58" ]]; then
    home_mode=$(curl -s "http://$api_target/webapi/entry.cgi?api=SYNO.SurveillanceStation.HomeMode&version=1&method=GetInfo&_sid=$sid" | jq .data.on)
    device_detected="false"
    for ip_address in ${!phone_list[@]}; do 
      ip neigh flush dev eth0 $ip_address >/dev/null 2>&1
      hping3 -2 -c 10 -p 5353 -i u1 $ip_address -q >/dev/null 2>&1
      arp -an $ip_address | awk '{print $4}' | grep ${phone_list[$ip_address]} >/dev/null 2>&1
      if [ $? -eq 0 ]; then
        echo "$(date): $ip_address is present" >> $log_location
        device_detected="true"
        break
      else
        echo "$(date): $ip_address is NOT present" >> $log_location
      fi
    done
    if [ $device_detected != $home_mode ]; then
      echo "$(date): toggle home_mode" >> $log_location
      curl -s "http://$api_target/webapi/entry.cgi?api=SYNO.SurveillanceStation.HomeMode&version=1&method=Switch&on=$device_detected&_sid=$sid" >/dev/null 2>&1
    else
      echo "$(date): don't toggle home_mode" >> $log_location
    fi
  fi
  echo -e "$(date): sleep 60 seconds...\n" >> $log_location
  sleep 60
done