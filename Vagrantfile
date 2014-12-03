# -*- mode: ruby -*-
# vi: set ft=ruby :

require File.expand_path('../config/init.rb', __FILE__)
require 'json'

VAGRANTFILE_API_VERSION = '2'
BASE_BOX = 'opscode-centos-6.5'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end

  # disable auto update on first run. need to update kernel first
  # if Vagrant.has_plugin?('vagrant-vbguest')
  #   config.vbguest.no_install = true
  # end

  config.vm.define :chef_server do |chef_server|
    chef_server.vm.box = BASE_BOX
    chef_server.vm.provider :virtualbox do |vb|
      vb.name = LocalConfig::Attr[:vb_name] || 'chefserver'
      vb.gui = LocalConfig::Attr[:vb_gui] || false
      vb.customize ['modifyvm', :id, '--memory', LocalConfig::Attr[:vb_memmory] || '256']
    end

    chef_server.vm.hostname = LocalConfig::Attr[:hostname] || 'chefserver'

    chef_server.vm.network 'private_network', ip: LocalConfig::Attr[:ip] || '192.168.33.10'
    chef_server.vm.network 'forwarded_port', id: 'ssh', guest: 22, host: LocalConfig::Attr[:ssh_host_port] || 2200

    # if Vagrant.has_plugin?('vagrant-omnibus')
    #   chef_server.omnibus.chef_version = :latest
    # else
    #   chef_server.vm.provision :shell, inline: 'curl -L https://www.getchef.com/chef/install.sh | sudo bash'
    # end

    if Vagrant.has_plugin?('vagrant-vbguest')
      update_kernel = <<-SCRIPT
      sudo yum -y install epel-release
      sudo yum makecache
      sudo yum -y update kernel && sudo yum -y install kernel-devel
      SCRIPT
      chef_server.vm.provision :shell, inline: update_kernel
      # system 'vagrant vbguest --do '
    end

    # chef_server.vm.provision :chef_solo do |chef|
    #   chef.cookbooks_path    = ChefConfig::Attr[:cookbooks_path]
    #   chef.data_bags_path    = ChefConfig::Attr[:data_bags_path]
    #   chef.roles_path        = ChefConfig::Attr[:roles_path]
    #   chef.environments_path = ChefConfig::Attr[:environments_path]

    #   chef.add_recipe 'chef-server'
    # end
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with CFEngine. CFEngine Community packages are
  # automatically installed. For example, configure the host as a
  # policy server and optionally a policy file to run:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.am_policy_hub = true
  #   # cf.run_file = "motd.cf"
  # end
  #
  # You can also configure and bootstrap a client to an existing
  # policy server:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.policy_server_address = "10.0.2.15"
  # end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "default.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { mysql_password: "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
