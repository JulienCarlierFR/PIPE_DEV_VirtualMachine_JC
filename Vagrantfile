#Démarrage VMs vagrant up                 vagrant up
#Arret VMs                                vagrant halt 
#Nettoyage VMs (remove all VM)            vagrant destroy
#Connexion SSH                            vagrant ssh debian-local-dev

#Plugin vagrant pour VirtualBox           vagrant plugin install vagrant-vbguest
#Plugin list                              vagrant plugin list
#                                           vagrant vbguest --status
#                                           vagrant vbguest --do install


Vagrant.configure("2") do |config|

    config.vm.define "debian-local-dev" do |debianlocaldev|
        debianlocaldev.vm.box = "boxomatic/debian-11"
        debianlocaldev.vm.hostname = "debianlocaldev"
        debianlocaldev.vm.box_url = "boxomatic/debian-11"
        debianlocaldev.vm.network :private_network, ip: "192.168.100.1"
        debianlocaldev.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 3072]
            v.customize ["modifyvm", :id, "--name", "debian-local-dev"]
            v.customize ["modifyvm", :id, "--cpus", "2"]
            v.gui = true
        end
        if Vagrant.has_plugin?("vagrant-vbguest") then
            config.vbguest.auto_update = false
        end
    config.vm.provision "shell", inline: <<-SHELL
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
        service ssh restart
    SHELL
    debianlocaldev.vm.provision "shell", path: "script_installation_debian64.sh"
    end
end
