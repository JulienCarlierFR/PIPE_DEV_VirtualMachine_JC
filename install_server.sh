#!/bin/bash

chmod +x ./__install_core.sh
./__install_core.sh server-debian-dev


##  CONFIGURATIONS =========================
CONF_FILE="conf_install_vm_server-debian-dev.conf"

## VARIABLES ===============================
IP=$(hostname -I | awk '{print $2}')


#   FUNCTIONS CORE ==========================
#Parse le fichier de conf et recupere la data (relation key=value)
#$1                 Clé recherché (var KEY_SEARCH_GLOBAL)
#DATA_KEY_GLOBAL    Résultat de la recherche (return)
KEY_SEARCH_GLOBAL=""
DATA_KEY_GLOBAL=""
function parseConfFile() {
    KEY_SEARCH_GLOBAL=$1

    DATA_KEY_GLOBAL=$(cat $CONF_FILE | grep "^$KEY_SEARCH_GLOBAL" | cut -d '=' -f 2 |  sed -e 's/\r//g')
}







## PAQUETS DE BASE =========================
#__install_core.sh
parseConfFile "CUSTOM_INSTALL_APT"
apt_base=$DATA_KEY_GLOBAL
apt-get install -y $apt_base > /dev/null





# DOCKER INSTALL & CONFIGURE ----------------
# Dependances installés ci-dessus (paquet de base)
#       ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

parseConfFile "DOCKER_INSTALL_APT"
apt_docker=$DATA_KEY_GLOBAL
apt-get install -y $apt_docker

echo "Installation Terminé SERVER - "$IP



echo "REBOOT ! ------------"
reboot