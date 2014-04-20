# puppet-skeleton

A puppet project skeleton uses [Librarian-Puppet](http://librarian-puppet.com/) and [Vagrant](http://www.vagrantup.com/).

## Development

* Install [VirtualBox](https://www.virtualbox.org/).
* Use [Vagrant](http://www.vagrantup.com/) for development, please install Vagrant according to the official instruction.
* Install [RVM](http://rvm.io).
* Switch to project directory and the correct ruby version should be installed according to [.ruby-version](https://github.com/hSATAC/puppet-skeleton/blob/master/.ruby-version).
* Install [bundler](http://bundler.io/) by running `$ gem install bundler`
* Run `$ bundle install` to install required rubygems.
* Run `$ librarian-puppet install` to install required puppet modules. Community modules and private modules will be installed in `modules` folder. See [Librarian-Puppet](http://librarian-puppet.com/) for further info.

## Usage

* Define your `node` in [vagrant.pp](https://github.com/hSATAC/puppet-skeleton/blob/master/manifests/vagrant.pp):
* Add community modules using librarian-puppet, edit [Puppetfile](https://github.com/hSATAC/puppet-skeleton/blob/master/Puppetfile) and run `$ librarian-puppet install`
* Add private modules under `private` folder, don't forget to edit `Puppetfile` as well. Run `$ rake module:sync` or `$ librarian-puppet install` to install them.
* `Roles` and `Profiles` located at top level of the project, for further information see [Roles and Profiles Pattern in Puppet](http://blog.hsatac.net/2014/04/roles-and-profiles-pattern-in-puppet/).
* Use `rake` tasks to speed up your puppet development.

You can now run `$ vagrant up` to bootstrap all of them at the same time in [VirtualBox](https://www.virtualbox.org/).

Other commands:

```bash
$ rake -T                                  # List all tasks.
$ rake -D                                  # List all tasks with descriptions.
$ rake module:lint                         # Puppet lint.
$ rake module:reinstall                    # Clean and reinstall modules.
$ rake module:sync                         # Sync private modules.
$ rake syntax                              # Syntax check Puppet manifests and templates
$ rake syntax:hiera                        # Syntax check Hiera config files
$ rake syntax:manifests                    # Syntax check Puppet manifests
$ rake syntax:templates                    # Syntax check Puppet templates
$ rake vagrant:provision[name,provisioner] # Provision vagrant VM.
$ rake vagrant:rebuild[name]               # Rebuild vagrant VM.
```

## Structure

```bash
.
├── Gemfile             # Required rubygems, use bundler to install.
├── Puppetfile          # Required puppet modules, use librarian-puppet to install.
├── README.md
├── Rakefile            # Some predefined tasks, to speed up development.
├── Vagrantfile         # Vagrant configuration.
├── hiera.yaml          # Puppet hiera config, only define hierarchy and datadir in this file.
├── docs                # Some documents
├── manifests
│   ├── hieradata         # The actual heirdata stored in this folder.
│   ├── site.pp           # Node definition for production.
│   └── vagrant.pp        # Node definition for local development.
├── private             # Private modules, will be sync into `modules` folder by `librarian-puppet`.
│   ├── common
│   └── users
├── profile             # Profile, abstraction of "Technology stack"
│   ├── files
│   └── manifests
├── role                # Role, abstraction of "What does this server do?"
│   └── manifests
├── spec                # Put test files
└── scripts
    └── upgrade_puppet.sh # Script of upgrading puppet to version 3 on Ubuntu
```
## Bootstrap on Amazon Web Services

You can bootstrap AWS instance in these 2 ways to test:

### Manually

* Create an Ubuntu instance, copy this repo into instance and run [scripts/upgrade_puppet.sh](https://github.com/hSATAC/puppet-skeleton/blob/master/scripts/upgrade_puppet.sh) to install the latest puppet.
* Setup the correct hostname.
* Apply masterless puppet by running `$ puppet apply --parser future --modulepath './modules' --hiera_config=./hiera.yaml --manifestdir ./manifests`

### Vagrant-AWS

* Install [Vagrant-AWS](https://github.com/mitchellh/vagrant-aws) plugin: `$ vagrant plugin install vagrant-aws`.
* Add a dummy box for AWS: `$ vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box`.
* Uncomment AWS related section in [Vagrantfile](https://github.com/hSATAC/puppet-skeleton/blob/master/Vagrantfile).
* Fill AWS credentials and other info.
* Run `$ vagrant up aws-web --provider=aws` to bootstrape machine `aws-web`.
* Or create other machine according to the `aws-web` example.

## TODO

* Move AWS credentials into config file.
* Add acceptence tests using [Beaker](https://github.com/puppetlabs/beaker/wiki/How-To-Beaker)
