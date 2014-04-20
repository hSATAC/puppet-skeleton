# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Ubuntu 12.04 lts 64
  config.vm.box = "hashicorp/precise64"

  # Upgrade Puppet from 2.7 to 3.x
  config.vm.provision :shell, :path => "scripts/upgrade_puppet.sh"

  # Puppet config
  puppet_block = lambda do |puppet|
    puppet.options = "--parser future --verbose --debug" # For debug only
    #puppet.options = "--parser future"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "vagrant.pp"
    puppet.module_path    = "modules"
    puppet.hiera_config_path = "hiera.yaml"
  end

  config.vm.provider "virtualbox" do |vb, override|
    override.vm.provision "puppet", &puppet_block
  end

  # Defining nodes
  config.vm.define "web" do |web|
    web.vm.hostname = "web01"
  end

=begin
  # AWS config
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ""
    aws.secret_access_key = ""
    aws.keypair_name = ""

    aws.ami = "ami-85c7b984" # ubuntu-precise-12.04-amd64-server-20140408, paravirtual
    aws.region = "ap-northeast-1"
    aws.instance_type = "t1.micro"

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = ""
  end

  # AWS node
  config.vm.define "aws-web" do |web|
    web.vm.box = "dummy"
    web.vm.hostname = "web01"

    # Set vm.hostname is not working for vagrant-aws, so we have to pass custom factor to puppet.
    web.vm.provision "puppet" do |puppet|
      puppet_block.call(puppet)
      puppet.facter = {
        'hostname' => web.vm.hostname,
      }
    end
  end
=end
end
