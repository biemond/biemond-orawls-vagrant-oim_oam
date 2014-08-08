# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "oim1admin" , primary: true do |oim1admin|

    oim1admin.vm.box = "centos-6.5-x86_64"
    oim1admin.vm.box_url = "https://dl.dropboxusercontent.com/s/np39xdpw05wfmv4/centos-6.5-x86_64.box"

    oim1admin.vm.hostname = "oim1admin.example.com"
    oim1admin.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=777"]
    oim1admin.vm.synced_folder "/Users/edwin/software", "/software"

    oim1admin.vm.network :private_network, ip: "10.10.10.61"
  
    oim1admin.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "5548"]
      vb.customize ["modifyvm", :id, "--name"  , "oim1admin"]
      vb.customize ["modifyvm", :id, "--cpus"  , 2]
    end
  
    oim1admin.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppet/hiera.yaml;rm -rf /etc/puppet/modules;ln -sf /vagrant/puppet/modules /etc/puppet/modules"
    
    oim1admin.vm.provision :puppet do |puppet|
      puppet.manifests_path    = "puppet/manifests"
      puppet.module_path       = "puppet/modules"
      puppet.manifest_file     = "site.pp"
      puppet.options           = "--verbose --hiera_config /vagrant/puppet/hiera.yaml"
  
      puppet.facter = {
        "environment"    => "development",
        "vm_type"        => "vagrant",
      }
      
    end
  
  end

  config.vm.define "oimoud" , primary: true do |oimoud|

    oimoud.vm.box = "centos-6.5-x86_64"
    oimoud.vm.box_url = "https://dl.dropboxusercontent.com/s/np39xdpw05wfmv4/centos-6.5-x86_64.box"

    oimoud.vm.hostname = "oimoud.example.com"
    oimoud.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=777"]
    oimoud.vm.synced_folder "/Users/edwin/software", "/software"

    oimoud.vm.network :private_network, ip: "10.10.10.71"
  
    oimoud.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--name"  , "oimoud"]
      vb.customize ["modifyvm", :id, "--cpus"  , 1]
    end
  
    oimoud.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppet/hiera.yaml;rm -rf /etc/puppet/modules;ln -sf /vagrant/puppet/modules /etc/puppet/modules"
    
    oimoud.vm.provision :puppet do |puppet|
      puppet.manifests_path    = "puppet/manifests"
      puppet.module_path       = "puppet/modules"
      puppet.manifest_file     = "site.pp"
      puppet.options           = "--verbose --hiera_config /vagrant/puppet/hiera.yaml"
  
      puppet.facter = {
        "environment"   => "development",
        "vm_type"       => "vagrant",
      }
      
    end
  
  end

  config.vm.define "oimdb" , primary: true do |oimdb|
    oimdb.vm.box = "centos-6.5-x86_64"
    oimdb.vm.box_url = "https://dl.dropboxusercontent.com/s/np39xdpw05wfmv4/centos-6.5-x86_64.box"

    oimdb.vm.hostname = "oimdb.example.com"
    oimdb.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=777"]
    oimdb.vm.synced_folder "/Users/edwin/software", "/software"

    oimdb.vm.network :private_network, ip: "10.10.10.9"
  
    oimdb.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm"     , :id, "--memory", "2532"]
      vb.customize ["modifyvm"     , :id, "--name"  , "oimdb"]
      vb.customize ["modifyvm"     , :id, "--cpus"  , 2]
    end

  
    oimdb.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppet/hiera.yaml;rm -rf /etc/puppet/modules;ln -sf /vagrant/puppet/modules /etc/puppet/modules"
    
    oimdb.vm.provision :puppet do |puppet|
      puppet.manifests_path    = "puppet/manifests"
      puppet.module_path       = "puppet/modules"
      puppet.manifest_file     = "db.pp"
      puppet.options           = "--verbose --hiera_config /vagrant/puppet/hiera.yaml"
  
      puppet.facter = {
        "environment" => "development",
        "vm_type"     => "vagrant",
      }
      
    end
  
  end

end
