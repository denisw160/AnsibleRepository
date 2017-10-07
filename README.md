# Repository for Ansible

## Installation
First install your machine with Ubuntu, you can download the Ubuntu Server from https://www.ubuntu.com/download/server. 
Mount the image in the virtual machine and power up. Run the installer with your favorite setting. Add the OpenSSH Server
to your installation. 

After install connect to the server via SSH.
Login in the server (via ssh) with your admin account and execute the following steps: 

1. Disable SUDO password question

    ```bash
    $ sudo visudo -f /etc/sudoers.d/[your admin user]
    ```
    and add the following line
    ``` 
    [your admin user]  ALL=NOPASSWD:ALL
    ```

1. Install Ansible on the server
    
    ```bash
    $ sudo apt-get update
    $ sudo apt-get install software-properties-common
    $ sudo apt-add-repository ppa:ansible/ansible
    $ sudo apt-get update
    $ sudo apt-get install ansible
    ```

1. Setup the ssh key for the server
    
    ```bash
    $ mkdir ~/.ssh
    $ chmod 700 ~/.ssh
    $ ssh-keygen -t rsa
	```
    
    then copy the ssh-key to remote server
    ```bash
    $ ssh-copy-id [your admin user]@localhost
    ```

1. Adding the host to Ansible hosts (optional)
    ```bash
    $ sudo nano /etc/ansible/hosts
    ```
    by add the following lines
    ```ini
    # Server
    [server]
    localhost
    ```

1. Testing the configuration (optional)
    ```bash
    $ ansible server -m ping
    ```
    The result look like that
    ```ini
    localhost | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    ```

## Customizing

If you want to customize the installation all Ansible variables are stored in
group_vars.

## Setup the roles and server

Now the server is prepared for setup with Ansible. This directory must be transferred
to the server and before execute the Ansible playbooks.

The host are configured in the following files 
 - production: for productive servers
 - staging: for pre-live servers
 - development: for testing servers
 
In the main.yml you can setup / change the roles for the servers.

1. Execute the Ansible playbook
    ```bash
    $ ansible-playbook -i [production|staging|development] main.yml
    ```

1. Check the result from the Ansible commandline.

# Roles

The following roles can be used and customized in the Ansible playbooks.

## Roles

## Variables


# General

For using Ansible used the documentation on: http://docs.ansible.com/ansible/latest/playbooks_best_practices.html.

## Directory Layout

This repository use the 

	production                # inventory file for production servers
	staging                   # inventory file for staging environment
	development				  # inventory file for testing environment

	group_vars/
	   all                    # variables for all groups (optional)
	   group1                 # here we assign variables to particular groups (optional)
	   group2                 # ""
	host_vars/
	   hostname1              # if systems need specific variables, put them here (optional)
	   hostname2              # ""

	library/                  # if any custom modules, put them here (optional)
	module_utils/             # if any custom module_utils to support modules, put them here (optional)
	filter_plugins/           # if any custom filter plugins, put them here (optional)

	main.yml                  # master playbook

	roles/
	    common/               # this hierarchy represents a "role"
	        tasks/            # 
	            main.yml      #  <-- tasks file can include smaller files if warranted
	        handlers/         #
	            main.yml      #  <-- handlers file
	        templates/        #  <-- files for use with the template resource
	            ntp.conf.j2   #  <------- templates end in .j2
	        files/            #
	            bar.txt       #  <-- files for use with the copy resource
	            foo.sh        #  <-- script files for use with the script resource
	        vars/             #
	            main.yml      #  <-- variables associated with this role
	        defaults/         #
	            main.yml      #  <-- default lower priority variables for this role
	        meta/             #
	            main.yml      #  <-- role dependencies
	        library/          # roles can also include custom modules (optional)
	        module_utils/     # roles can also include custom module_utils (optional)
	        lookup_plugins/   # or other types of plugins, like lookup in this case (optional)

	    other/                # same kind of structure as "common" was above
