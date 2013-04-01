#Overview

This repository contains a bare-bones environment, which will help you bootstrap a Development VM running **Ubuntu 12.04 LTS** using [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/)

##Assumptions
1. You have a sane Development platform. At GDS, we use MacOSX, where this environment has been tested. It might work with modifications on Linux or Windows, although we have not tested this.
2. You have a sane Ruby 1.9.3 environment (this uses `sample` which is not in Ruby 1.8.7), with the `rake` command available.
3. You have installed Oracle VirtualBox (version 4.2.6 or above)
4. You have forked this repository into your own Github organisation (or Github Enterprise environment), so that you can commit to it.

#Instructions

## 1. Decide on your "development" domain.

This repository assumes a development domain of `dev.services.gov.uk` - you should make appropriate adjustments to the three relevant lines in the `Vagrantfile` and commit them, if you do not intend to develop using this domain.

## 2. Bring up a development VM.

Within the checked out copy of this repository, run the `rake` command. This will:

1. Install the relevant Ruby Gems using bundler.
2. Download any external Puppet modules with `librarian-puppet`.
3. Create Vagrantfile.local which will set a random IP for your VM.
4. Download an Ubuntu Image and create a VM (This will include running Puppet).
5. Connect to the VM over SSH.

At this point you will be connected to an Ubuntu 12.04 as the `vagrant` user. Sudo is available and the `vagrant` password is also "vagrant".

## 3. Modify your VM using puppet

The intention of this Repo is to provide a development platform where you can customise the VM using Puppet. This puppet code can then be transferred to a shared environment, where you can also use it to provision your test and live services if you wish.

### 3.1 Including External Puppet Modules 

Where possible, you should aim not to re-invent the wheel. [Puppet Forge](https://forge.puppetlabs.com/) contains a large number of externally developed modules (of varying quality), that you can use to help configure your environment. The find out more about how to include external dependencies, please see the [README for Librarian Puppet](https://github.com/rodjek/librarian-puppet)

### 3.2 Writing your own modules

This repo has a `modules` directory, where you can place your own custom Puppet modules. This avoids cluttering up the `manifests` directory, where resources are applied to machines (you may extend this repository later to have more than one machine type).

If you are writing your own modules, it is important that you also test them, so that any negative changes in behaviour are caught before applying them to the VM. One tool to do this is [RSpec Puppet](http://rspec-puppet.com/) which includes a linked tutorial on writing puppet tests.

### 3.3 Applying changes to your VM

`manifests/site.pp` includes a single node called **default** - adding puppet resources (via includes, classes or [native puppet types](http://docs.puppetlabs.com/references/latest/type.html)) to this node definition will make them available to your VM.

To apply changed puppet code to your VM, from within this repository you can use the `rake update` command which will update any gems listed in the Gemfile, download any librarian modules from the Puppetfile and then run `puppet apply` within the VM.

### 3.4 Viewing your changes

This repository uses the vagrant-dns Gem, which will install a file in `/etc/resolver/` on your OSX machine. This file tells the OSX DNS resolver to point all requests for *.dev.services.gov.uk to your VM - assuming that you have a webserver or application listening, you should be able to see this using your local browser.

#Full list of Rake commands

```
rake config            # Create Vagrantfile.local
rake connect           # Connect to the VM
rake create            # Create the VM
rake destroy           # Destroy the VM
rake update            # Update the VM
rake update:bundle     # Update Gems via Bundler
rake update:library    # Run Librarian Puppet for deps
rake update:provision  # Run Vagrant Provision on the VM
```
From within the repository, you can also use vagrant commands such as `vagrant up`, `vagrant halt` and `vagrant provision` if you wish. The Rake helper tasks are provided purely for the convenience of a new user.
