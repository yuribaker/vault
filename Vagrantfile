# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
  #This example uses three boxes for vault. vault1, vault2, and vault3. 
    (1..3).each do |i|
        config.vm.define "vault#{i}" do |server|
            server.vm.box = "bento/centos-7.5" #Downloads and opens VM. Here is a list of prepacked vm boxes https://app.vagrantup.com/boxes/search
            server.vm.box_version = "201805.15.0" #Version number of box
            server.vm.hostname = "vault#{i}" #names host
            server.vm.network :private_network, ip: "192.168.13.3#{i}"
            server.vm.provision "shell", path: "account.sh", args: "vault" #Creates a user:vault, group:vault, home:/srv/vault login disabled
            # server.vm.provision "shell", path: "account.sh", args: "consul" #Creates a user:consul, group:consul, home:/srv/consul login disabled
            server.vm.provision "shell", path: "prereqs.sh" #installs unzip bind-utils ruby rubygems ntp starts ntp service
            # server.vm.provision "shell", path: "consulsystemd.sh" #uploads service files and consul start script, chmods files too
            server.vm.provision "shell", path: "vaultsystemd.sh" #uploads service files for vault
            # server.vm.provision "shell", path: "consuldownload.sh" #Downloads consul
            # server.vm.provision "shell", path: "configureconsul.sh" #uploads consul config and sets cron job for consul snapshot once per hour
            # server.vm.provision "shell", inline: "sudo systemctl enable consul.service" #Enables consul to survive reboot
            # server.vm.provision "shell", inline: "sudo systemctl start consul" #Starts consul
            server.vm.provision "shell", path: "vaultdownload.sh", args: ["1.10.0", "/usr/local/bin"] #Downloads vault binary and creats folders and file for vault, adds VAULT_ADDR=http://localhost:8200 to vault.sh

            
            # ##  API Provisioning
            # if "#{i}" == "3"
            #     server.vm.provision "shell", inline: "consul members; curl localhost:8500/v1/catalog/nodes ; sleep 15" #polls to see consul members
            #     server.vm.provision "shell", inline: "echo 'Provisioning Consul ACLs via this host: '; hostname" #Just an echo :)
            #     server.vm.provision "shell", path: "provision_consul/scripts/acl/consul_acl.sh" # Does consul stuff
            #     server.vm.provision "shell", path: "provision_consul/scripts/acl/consul_acl_vault.sh" # Does more consul stuff
            #     server.vm.provision "shell", path: "init.sh"
            #     else
            #     server.vm.provision "shell", inline: "echo 'Not provisioning Consul ACLs via this host: '; hostname"
            # end
        end
    end


    config.vm.define "vault3" do |consul_acl|
#        consul_acl.vm.provision "shell", preserve_order: true, inline: "echo 'Provisioning Consul ACLs via this host: '; hostname"
#        consul_acl.vm.provision "shell", preserve_order: true, path: "provision_consul/scripts/acl/consul_acl.sh"
#        consul_acl.vm.provision "shell", preserve_order: true, path: "provision_consul/scripts/acl/consul_acl_vault.sh"
    end

    (1..3).each do |i|
        config.vm.define "vault#{i}" do |vault|
            vault.vm.provision "shell", path: "configureraftvault.sh", args: "#{i}" #Gets the store consul token and creates the vault.hcl config file for each vault vm 
            vault.vm.provision "shell", preserve_order: true, inline: "sudo systemctl enable vault.service" #Enables vault to survive reboot
            vault.vm.provision "shell", preserve_order: true, inline: "sudo systemctl start vault" #Starts vault
            vault.vm.provision "shell", path: "Splunk/configureuf.sh"
            vault.vm.provision "shell", path: "vaultsystemd.sh" #uploads service files for vault

        end
    end

  ##  Consul ACL Configuration
  ##  You'll notice that Consul ACL bootstrapping only succeeds on the first VM.
  ##  Choice of instance5 is not arbitrary. It could be done from within any instance
  ##  running one of the members of the Consul cluster, but instance5
  ##  gets provisioned first.

  ##  Vault's start may only happen after Consul ACL Configuration, because
  ##  it requires a Consul ACL to exist on a running Consul Cluster.

  ##  DB Secret backend
    # config.vm.define "db" do |db|
    #     db.vm.box = "bento/centos-7.5"
    #     db.vm.box_version = "201805.15.0"
    #     db.vm.network :private_network, ip: "192.168.13.187"
    #     db.vm.provision "ansible_local" do |ansible|
    #         ansible.playbook = "/vagrant/playbooks/prereqs.yaml"
    #     end
    #     db.vm.provision "ansible_local" do |ansible|
    #         ansible.playbook = "/vagrant/playbooks/mariadb.yaml"
    #         ansible.extra_vars = {'enable_external_conn': true, 'add_root_priv': !ARGV.include?('provision')}
    #     end
    # end
    config.vm.define "splunk" do |splunk|
        splunk.vm.box = "bento/centos-7.5"
        splunk.vm.box_version = "201805.15.0"
        splunk.vm.network :private_network, ip: "192.168.13.101"
        splunk.vm.provision "shell", preserve_order: true, path: "Splunk/configureSplunk.sh" 
    end
end
