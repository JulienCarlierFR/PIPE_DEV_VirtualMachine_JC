#!/bin/bash
chmod +x ./__install_core.sh
./__install_core.sh

##  CONFIGURATIONS =========================
CONF_FILE="conf_install_vm_debianlocaldev.conf"



## VARIABLES ===============================

#   FUNCTIONS CORE ==========================
#Parse le fichier de conf et recupere la data (relation key=value)
#$1                 Clé recherché (var KEY_SEARCH_GLOBAL)
#DATA_KEY_GLOBAL    Résultat de la recherche (return)
KEY_SEARCH_GLOBAL=""
DATA_KEY_GLOBAL=""
function parseConfFile() {
    KEY_SEARCH_GLOBAL=$1

    DATA_KEY_GLOBAL=`cat $CONF_FILE | grep "^$KEY_SEARCH_GLOBAL" | cut -d '=' -f 2`
}



#Ajout d'un user +mdp selon le conf file 
function conf_addUserWithPasswd() {
    KEY_LOGIN_CONF="USER1_LOGIN"            ##Clé/Valeur login
    KEY_PASSWD_CONF="USER1_PASSD"           ##Clé/Valeur Passwd
    user1_login=""
    user1_passwd=""

    echo '-------------- AJOUT UTILISATEUR --------------'
    
    #Recup des données -> Recup de l'info login
    parseConfFile $KEY_LOGIN_CONF
    user1_login=$DATA_KEY_GLOBAL 
    echo $user1_login

    #recup du pass en clair
    parseConfFile $KEY_PASSWD_CONF
    user1_passwd=$DATA_KEY_GLOBAL 
    echo $user1_passwd

    #Encrypt passwd
    user1_passwd_enc=$(perl -e "print crypt('$loc_passwd', 'salt')")
    echo $user1_passwd_enc

    useradd -m -p $user1_passwd_enc $user1_login

    echo '-------------- !AJOUT UTILISATEUR --------------'
}







## PAQUETS DE BASE =========================
#__install_core.sh
parseConfFile "CUSTOM_INSTALL_APT"
custom_apt=$DATA_KEY_GLOBAL 
echo "installation custom :"$custom_apt
apt-get install -y $custom_apt > /dev/null

echo "Installation Terminé DESKTOP - "$IP



# ACTION 
#parseConfFile "USER1_LOGIN"
#echo $DATA_KEY_GLOBAL
#echo "------------"
conf_addUserWithPasswd

reboot