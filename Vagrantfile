IMAGE_NAME = "bento/ubuntu-16.04"
N = 2

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
    config.vbguest.auto_update = true
    config.vm.box_check_update = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
    end

    config.vm.define "master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.network "forwarded_port", guest:80, host: 32500
        master.vm.hostname = "master"
      	if Vagrant::Util::Platform.windows? then
      	# Configuration SPECIFIC for Windows 10 hosts
        	master.vm.synced_folder "examples", "/home/vagrant/examples",
          	id: "vagrant-root", ouner: "vagrant", group: "vagrant",
          	mount_options: ["dmode=775,fmode=664"]
        else
      		# Configuration for Unix/Linux hosts
        	master.vm.synced_folder "examples", "/home/vagrant/examples"
      end
    end

    (1..N).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            node.vm.hostname = "node-#{i}"
        end
    end

        # create Management (mgmt) node
    config.vm.define "mgmt" do |mgmt_config|
      mgmt_config.vm.box = IMAGE_NAME
      mgmt_config.vm.hostname = "mgmt"
      mgmt_config.vm.network "private_network", ip: "192.168.50.9"
      if Vagrant::Util::Platform.windows? then
      # Configuration SPECIFIC for Windows 10 hosts
        mgmt_config.vm.synced_folder "examples", "/home/vagrant/examples",
        id: "vagrant-root", ouner: "vagrant", group: "vagrant",
        mount_options: ["dmode=775,fmode=664"]
      else
      # Configuration for Unix/Linux hosts
        mgmt_config.vm.synced_folder "examples", "/home/vagrant/examples"
      end

      mgmt_config.vm.provider "virtualbox" do |vb|
          vb.name = "mgmt"
          opts = ["modifyvm", :id, "--natdnshostresolver1", "on"]
          vb.customize opts
          vb.memory = "512"
        end
        mgmt_config.vm.provision "shell", path: "bootstrap-mgmt.sh"
    end
end
