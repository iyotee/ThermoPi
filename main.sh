
#!/bin/bash
# Script : my-pi-temp.sh
# Purpose: Afficher la température du CPU ARM, du GPU et des SSD NVMe du Raspberry Pi 5 en temps réel
# Author: Jérémy Noverraz
# -------------------------------------------------------
trap 'echo "Arrêt du script." && exit 0' SIGINT

while true; do
    cpu=$(</sys/class/thermal/thermal_zone0/temp)
    nvme0_temp=$(sudo smartctl -a /dev/nvme0n1 | grep "Temperature:" | awk '{print $2}')
    nvme1_temp=$(sudo smartctl -a /dev/nvme1n1 | grep "Temperature:" | awk '{print $2}')

    echo "$(date) @ $(hostname)"
    echo "-------------------------------------------"
    echo -e "GPU => \e[32m$(/usr/bin/vcgencmd measure_temp | sed 's/temp=//')\e[0m"
    echo -e "CPU => \e[32m$((cpu/1000))'C\e[0m"
    echo -e "NVMe 0 => \e[32m$nvme0_temp°C\e[0m"
    echo -e "NVMe 1 => \e[32m$nvme1_temp°C\e[0m"

    sleep 1
    clear
done
