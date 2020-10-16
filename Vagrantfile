# encoding: utf-8


Vagrant.configure(2) do |config|
  config.vm.define "k3s-server" do |server|
    server.vm.box = "#{ENV['SERVER_BOX']}"
    server.vm.guest = :linux
    server.vm.boot_timeout = 60
    server.vm.provider :virtualbox do |v|
      v.name = "#{ENV['SERVER_VM_NAME']}"
      v.customize ["setextradata", "#{v.name}",  "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", "0"]
      v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
      v.customize ["modifyvm", :id, "--nic2", "hostonly"]
      v.customize ["modifyvm", :id, "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
    server.vm.synced_folder '.', '/vagrant', disabled: true
    #server.vm.hostname = "k3s-server"
    server.ssh.username="rancher"
    server.ssh.private_key_path= "#{ENV['SSH_PKF']}"
  end

  COUNT=Integer(ENV['NODES_NUM'])
  (1..COUNT).each do |i|
    config.vm.define "k3s-agent-#{i}" do |node|
      node.vm.box = "#{ENV['AGENT_BOX']}"
      node.vm.guest = :linux
      node.vm.boot_timeout = 60
      node.vm.provider :virtualbox do |v|
        v.name = "#{ENV['AGENT_VM_NAME_BASE']}-#{i}"
        v.customize ["setextradata", "#{v.name}",  "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", "0"]
	v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
	v.customize ["modifyvm", :id, "--nic2", "hostonly"]
	v.customize ["modifyvm", :id, "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
      end
      node.vm.synced_folder '.', '/vagrant', disabled: true
      #node.vm.hostname = "k3s-agent-#{i}"
      node.ssh.username="rancher"
      node.ssh.private_key_path= "#{ENV['SSH_PKF']}"
    end
  end

end
