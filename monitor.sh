#!/bin/bash
while true;do
    disk=$(df --output=pcent / | tr -dc '0-9')
    cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')
    Cpu=${cpu%.*}
    ram=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    Ram=${ram%.*}

    message_for_cpu="Current CPU Usage: $Cpu"

    message_for_ram="Current RAM Usage: $Ram"

    message_for_disk="Current DISK Usage: $disk"

    if [ "$disk" -ge "10" ]; then

        curl --url 'smtps://smtp.example.com:465' --ssl-reqd --mail-from 'mail@example.com' --mail-rcpt 'to@example.com' --user 'user@example.com:password' --upload-file - <<EOF
Subject: Disk Usage


Disk utilization is high please check. $message_for_disk 
EOF


    fi
    if [ "$Cpu" -ge "80" ];then
        curl --url 'smtps://smtp.example.com:465' --ssl-reqd --mail-from 'mail@example.com' --mail-rcpt 'to@example.com' --user 'user@example.com:password' --upload-file - <<EOF
Subject: CPU Usage


Disk utilization is high please check. $message_for_cpu
EOF

    fi
    if [ "$Ram" -ge "80" ];then
        curl --url 'smtps://smtp.example.com:465' --ssl-reqd --mail-from 'mail@example.com' --mail-rcpt 'to@example.com' --user 'user@example.com:password' --upload-file - <<EOF
Subject: RAM Usage


Disk utilization is high please check. $message_for_ram
EOF

        fi
    sleep 60
done

