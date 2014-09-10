# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Ensure have vagrant-omnibus -plugin
if !Vagrant.has_plugin?('vagrant-omnibus')
  raise "vagrant-omnibus -Vagrant plugin is required. Please run: vagrant plugin install vagrant-omnibus"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Ubuntu box from http://opscode.github.io/bento/
  config.vm.box = 'ubuntu-14.04'
  config.vm.box_url = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'

  #config.vm.synced_folder ".", "/cookbooks/hadoop"
  config.vm.synced_folder "berks-cookbooks", "/cookbook_deps"

  # Ensure box have latest Chef installed
  config.omnibus.chef_version = :latest
  
  # Link Vagrant-hosts to /etc/hosts
  config.vm.provision :shell, :inline => "sudo cp /vagrant/Vagrant-hosts /etc/hosts"

  # Configs for Chef in both VMs
  chef_configs = {
    'hadoop' => {
      'namenode' => {
        'host' => 'hadoop-master'
      },
      'resourcemanager' => {
        'host' => 'hadoop-master'
      } 
    }
  }

  # Master VM
  config.vm.define 'master' do |config|

    config.vm.hostname = 'hadoop-master'

    config.vm.network :private_network, ip: '192.168.60.101'
    
    config.vm.provision :chef_solo do |chef|
      
      chef.add_recipe 'hadoop::namenode'
      chef.add_recipe 'hadoop::resourcemanager'
      chef.add_recipe 'minitest-handler'
      
      chef.json = chef_configs

      chef.custom_config_path = "./Vagrant_chef_config.rb"
    end
  end

  # Slave VM
  config.vm.define 'slave' do |config|

    config.vm.hostname = 'hadoop-slave'

    config.vm.network :private_network, ip: '192.168.60.102'
    
    config.vm.provision :chef_solo do |chef|
      
      chef.add_recipe 'hadoop::datanode'
      chef.add_recipe 'hadoop::nodemanager'
      chef.add_recipe 'minitest-handler'
      
      chef.json = chef_configs

      chef.custom_config_path = "./Vagrant_chef_config.rb"
    end
  end

end
