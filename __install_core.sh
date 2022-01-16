#!/bin/bash



#$1 --> nom de la machine à installer (permet acces au config file)



##  CONFIGURATIONS =========================
CONF_FILE="conf_install_vm_$1.conf"
APT_INSTALL_BASE="git openssh-server wget atop htop curl terminator"


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

    #user1_login=jcarlier                            # /!\ bug, necessite de fixer la variable au lieu de lire le fichier de conf  (fct parseConfFile)
    useradd -m -p $user1_passwd_enc $user1_login

    echo '-------------- !AJOUT UTILISATEUR --------------'
}








## PAQUETS DE BASE =========================
echo "START - update et upgrade - "$IP
apt-get update  > /dev/null
apt-get upgrade -y > /dev/null

echo "Installation des paquets de bases - "$IP
#task-gnome-desktop bashtop

apt-get install -y $APT_INSTALL_BASE > /dev/null


#AJOUT UTILISATEUR
conf_addUserWithPasswd


echo "Installation CORE Terminé - "$IP