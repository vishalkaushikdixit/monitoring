#!/bin/bash
while true;do
    disk=$(df --output=pcent / | tr -dc '0-9')
    cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')
    Cpu=${cpu%.*}
    ram=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    Ram=${ram%.*}
    if [ "$disk" -ge "80" ]; then
        curl --ssl-reqd \
            --url 'smtps://smtp.gmail.com:465' \
            --user 'username@gmail.com:password' \
            --mail-from 'username@gmail.com' \
            --mail-rcpt 'to@example.com' \
            --upload-file disk_usage.txt

    fi
    if [ "$Cpu" -ge "80" ];then
        curl --ssl-reqd \
            --url 'smtps://smtp.gmail.com:465' \
            --user 'username@gmail.com:password' \
            --mail-from 'username@gmail.com' \
            --mail-rcpt 'to@example.com' \
            --upload-file cpu_usage.txt
    fi
    if [ "$Ram" -ge "80" ];then
        curl --ssl-reqd \
            --url 'smtps://smtp.gmail.com:465' \
            --user 'username@gmail.com:password' \
            --mail-from 'username@gmail.com' \
            --mail-rcpt 'to@example.com' \
            --upload-file ram_usage.txt
        fi
    sleep 60
done

