## Chef Server Bootstrap ##
### What this script will do ###
- Using chef solo to quickly install a chef server instance on CentOS 6.5
- Copy the private key (.pem) files from the chef-server to the local .chef directory. You may use the admin user if you are the only user using this server. client-validator is a required key.
- Create two network interfaces. A NAT interface for internet access. A Host-only interface for consistent connectivity between the workstation with the server and the other VMs

### How to use it ###
- Clone this repo
- Install [Vagrant](https://www.vagrantup.com/), and [Virtual Box](https://www.virtualbox.org/)
- From the terminal execute `vagrant box add opscode-centos-6.5 https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box` (this image can also be reused for [test-kitchen](https://github.com/test-kitchen/test-kitchen))
- Copy `config/local.rb.example` to `config/local.rb` | You don't need to change anything if you are not planning to override the default settings.
- From the terminal execute `vagrant up`
- Add '192.168.33.10 chefserver' or the overridden LocalConfig::Attr[:ip] to your hosts file
- Add other virtual machines to the same Host-only network if you want them to work with each other.
- Once the machine finishes installing, go to https://chefserver (or https://192.168.33.10) to verify that the server is working. There will be a warning the first time you do this because there is no SSL certificate on this server. This is normal, just add an exception.

### Recommended Plugins ###
- The script still works without any of them. But they will make working Vagrant a bit easier
- [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier)
- [vagrant-vbox-snapshot](https://github.com/dergachev/vagrant-vbox-snapshot)
- [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) works great most of the time however it's incompatible with base centos-6.5 [[issue](https://github.com/dotless-de/vagrant-vbguest/issues/141)] therefore it's disabled in this script. The work around involves `vagrant ssh` into the machine, update the kernel `sudo yum -y update kernel`, do a full `vagrant halt`, change `config.vbguest.no_install = false` before `vagrant up` again.
