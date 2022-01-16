#INTRO
Projet permettant de déployer une machine de développement en local et serveur si nécessaire. 
D'autres VM pourront être créer au fil du temps, en fonction des besoins (Serveur de test, PC de développement, ...) 


#CONFIGURATION
##DEBIAN-LOCAL-DEV :
---> Fichier : conf_install_vm_debianlocaldev.conf
USER1_LOGIN=xxxxx                   <= Login user1
USER1_PASSD=xxxxx                   <= Passwd user1
CUSTOM_INSTALL_APT=xxxxx  xxx       <= Paquets additionnels pour l'installation



##NOTES
Les étapes ci-dessous sont executées automatiquement dans le Vagrantfile. Aucune action est nécessaire, cette note explique simplement le fonctionnement du logiciel de déploiement.

Nécessite de provisionner les fichiers suivants dans la VM à la racine de : 
./conf_install_vm_debianlocaldev.conf
./__install_core.sh
./install_desktop.sh
    
puis execute les commandes suivantes : 
./__install_core.sh
./install_desktop.sh



