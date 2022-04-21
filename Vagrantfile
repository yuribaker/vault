# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.ssh.insert_key = false
  #This example uses three boxes for vault. vault1, vault2, and vault3. 
    config.vm.define "vault" do |vault|
        vault.vm.box = "bento/centos-7.5"
        vault.vm.box_version = "201805.15.0"
        vault.vm.network :private_network, ip: "192.168.13.100"
        vault.vm.provision "shell", path: "account.sh", args: "vault" #Creates a user:vault, group:vault, home:/srv/vault login disabled
        vault.vm.provision "shell", path: "prereqs.sh" #installs unzip bind-utils ruby rubygems ntp starts ntp service
        vault.vm.provision "shell", path: "vaultsystemd.sh" #uploads service files for vault
        vault.vm.provision "shell", path: "vaultdownload.sh", args: ["1.10.0", "/usr/local/bin"] #Downloads vault binary and creats folders and file for vault, adds VAULT_ADDR=http://localhost:8200 to vault.sh
        vault.vm.provision "shell", path: "Splunk/configureuf.sh"
        vault.vm.provision "shell", path: "configurefile.sh" #Gets the store consul token and creates the vault.hcl config file for each vault vm 
        vault.vm.provision "shell", path: "vaultsystemd.sh" #uploads service files for vault
        vault.vm.provision "shell", preserve_order: true, inline: "sudo systemctl enable vault.service" #Enables vault to survive reboot
        vault.vm.provision "shell", preserve_order: true, inline: "sudo systemctl start vault" #Starts vault
    end

    config.vm.define "splunk" do |splunk|
        splunk.vm.box = "bento/centos-7.5"
        splunk.vm.box_version = "201805.15.0"
        splunk.vm.network :private_network, ip: "192.168.13.101"
        splunk.vm.provision "shell", preserve_order: true, path: "Splunk/configureSplunk.sh" 
    end
end
