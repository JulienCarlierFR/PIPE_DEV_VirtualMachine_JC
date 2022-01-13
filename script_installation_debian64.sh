#!/bin/sh

##  CONFIGURATIONS =========================


## VARIABLES ===============================
IP=$(hostname -I | awk '{print $2}')


## PAQUETS DE BASE =========================
echo "START - update et upgrade - "$IP
apt-get update  > /dev/null
apt-get upgrade -y > /dev/null

echo "Installation des paquets de bases - "$IP
#task-gnome-desktop bashtop
apt-get install -y git openssh-server wget atop htop curl terminator gnome-core task-gnome-desktop > /dev/null

echo "Installation Terminé - "$IP
