#!/bin/bash
# Script : my-pi-temp.sh
# Purpose: Afficher la température du CPU ARM, du GPU et des SSD NVMe (et carte SD) du Raspberry Pi 5 en temps réel
# Author: Jérémy Noverraz
# -------------------------------------------------------

# Vérification de l'installation de smartctl
if ! command -v smartctl &> /dev/null; then
    echo "Installation de smartctl..."
    sudo apt-get update
    sudo apt-get install smartmontools
fi

trap 'echo "Arrêt du script." && exit 0' SIGINT

while true; do
    cpu=$(</sys/class/thermal/thermal_zone0/temp)
    gpu_temp=$(/usr/bin/vcgencmd measure_temp | sed 's/temp=//')

    # Vérification de la présence d'un NVMe
    if [ -e "/dev/nvme0n1" ]; then
        nvme0_temp=$(sudo smartctl -a /dev/nvme0n1 | grep "Temperature:" | awk '{print $2}')
        echo -e "NVMe 0 => \e[32m$nvme0_temp°C\e[0m"
    fi

    if [ -e "/dev/nvme1n1" ]; then
        nvme1_temp=$(sudo smartctl -a /dev/nvme1n1 | grep "Temperature:" | awk '{print $2}')
        echo -e "NVMe 1 => \e[32m$nvme1_temp°C\e[0m"
    fi

    # Vérification de la présence d'une carte SD
    if [ -e "/dev/mmcblk0" ]; then
        sd_temp=$(sudo smartctl -a /dev/mmcblk0 | grep "Temperature:" | awk '{print $2}')
        echo -e "Carte SD => \e[32m$sd_temp°C\e[0m"
    fi

    echo "$(date) @ $(hostname)"
    echo "-------------------------------------------"
    echo -e "GPU => \e[32m$gpu_temp\e[0m"
    echo -e "CPU => \e[32m$((cpu/1000))'C\e[0m"

    sleep 1
    clear
done
