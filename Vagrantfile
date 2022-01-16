#Démarrage VMs vagrant up                 vagrant up
#Arret VMs                                vagrant halt 
#Nettoyage VMs (remove all VM)            vagrant destroy
#Connexion SSH                            vagrant ssh debian-local-dev

#Plugin vagrant pour VirtualBox           vagrant plugin install vagrant-vbguest
#Plugin list                              vagrant plugin list
#                                           vagrant vbguest --status
#                                           vagrant vbguest --do install


Vagrant.configure("2") do |config|

    config.vm.define "local-debian-dev" do |debianlocaldev|
        debianlocaldev.vm.box = "boxomatic/debian-11"
        debianlocaldev.vm.hostname = "debianlocaldev"
        debianlocaldev.vm.box_url = "boxomatic/debian-11"
        debianlocaldev.vm.network :private_network, ip: "192.168.100.1"
        debianlocaldev.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 2048]
            v.customize ["modifyvm", :id, "--name", "local-debian-dev"]
            v.customize ["modifyvm", :id, "--cpus", "2"]
            v.customize ["modifyvm", :id, "--vram", "128"]
            v.gui = false
        end
        if Vagrant.has_plugin?("vagrant-vbguest") then
            config.vbguest.auto_update = false
        end
    config.vm.provision "shell", inline: <<-SHELL
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
        service ssh restart
    SHELL
    debianlocaldev.vm.provision "file", source: "./conf_install_vm_local-debian-dev.conf", destination: "./"
    debianlocaldev.vm.provision "file", source: "./__install_core.sh", destination: "./"                          #for debug
    debianlocaldev.vm.provision "file", source: "./install_desktop.sh", destination: "./"                         #for debug

    debianlocaldev.vm.provision "shell", path: "install_desktop.sh"
    end




    config.vm.define "debian-server-dev" do |serverdebiandev|
        serverdebiandev.vm.box = "boxomatic/debian-11"
        serverdebiandev.vm.hostname = "debianserverdev"
        serverdebiandev.vm.box_url = "boxomatic/debian-11"
        serverdebiandev.vm.network :private_network, ip: "192.168.100.2"
        serverdebiandev.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 2048]
            v.customize ["modifyvm", :id, "--name", "debian-server-dev"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
            v.gui = false
        end
        if Vagrant.has_plugin?("vagrant-vbguest") then
            config.vbguest.auto_update = false
        end
    config.vm.provision "shell", inline: <<-SHELL
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
        service ssh restart
    SHELL
    serverdebiandev.vm.provision "file", source: "./conf_install_vm_server-debian-dev.conf", destination: "./"
    serverdebiandev.vm.provision "file", source: "./__install_core.sh", destination: "./"                          #for debug
    serverdebiandev.vm.provision "file", source: "./install_server.sh", destination: "./"                          #for debug

    serverdebiandev.vm.provision "shell", path: "install_server.sh"
    end
end
