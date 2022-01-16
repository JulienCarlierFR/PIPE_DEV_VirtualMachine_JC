#!/bin/bash



chmod +x ./__install_core.sh
./__install_core.sh local-debian-dev


##  CONFIGURATIONS =========================
CONF_FILE="conf_install_vm_local-debian-dev.conf"
#CUSTOM_APT="gnome-core"

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
custom_apt=$DATA_KEY_GLOBAL 
echo "INSTALL CUSTOM : "$custom_apt
apt-get install -y $custom_apt > /dev/null
echo "INSTALL CUSTOM TERMINE"

echo "Installation Terminé DESKTOP - "$IP



echo "REBOOT ! ------------"
reboot