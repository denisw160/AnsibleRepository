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

Steps 1 to 3 are in the bash-script "install-ansible.sh".

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

## Other playbooks

Some other playbooks with simple tasks can be found in playbooks.

# Roles & Playbooks

The following roles can be used and customized in the Ansible playbooks. All playbooks used the host-group "servers".

## Roles

 - common
 	- Default role install common packages and create an admin and application user.
 - postfix
 	- Installed the mail system and setup the smart host.
 - java
 	- Install Oracle JDK.
 - apache2
 	- Install Apache2 with php.
 - tomcat
 	- Install Apache Tomcat.
 - mqtt
 	- Install a MQTT broker.
 - mariadb
 	- Installs the Mariadb database.
 - postgresql
 	- Installs the Postgresql database.
 - mongodb
 	- Installs the MongoDB.
 - cassandra
 	- Installs Apache Cassandra.
 - docker
 	- Install Docker.
 - docker-compose
 	- Install docker-compose and run as container. 
  - docker-registry 
 	- Deploy docker-registry on Port 5000. 
  - docker-cleanup
 	- Install container meltwater/docker-cleanup for cleanup old containers.
 - docker-maven
 	- Install a script to run maven as container.
 - docker-adminer 
 	- Deploy container Adminer on Port 9001. 
 - docker-postgres
 	- Deploy container PostgreSQL on Port 9432.
 - docker-sonarqube
 	- Running SonarQube with PostgreSQL on Port 9090.
 - docker-jenkins
 	- Deploy container Jenkins on Port 9091 and 50000.
 - portainer
 	- Deploy Portainer on Port 9000. 
 - rancher
 	- Deploy Rancher on Port 9000. 

## Variables

For role common:
 - admin_user
 	- username for the administrator
 	- default: admin
 - admin_password
 	- password for the administrator
 	- default admin
 - application_user
 	- username for application user
 	- default: apps
 - application_password
 	- password for the application user
 	- default: apps

For role postfix:
 - postfix_relyhost
 	- name for the postfix-server

For role apache2 you can install some features, set the variables to true for install. Default values are:
 - feature_phpmyadmin: false
 - feature_phppgadmin: false
 - feature_adminer: false

For role tomcat:
 - tomcat_user
 	- username for the administrator
 	- default: admin
 - tomcat_password
 	- password for the administrator
 	- default admin
 - feature_probe: true
 - feature_port_8181

For role mariadb:
 - mariadb_user: sqladmin
 - mariadb_password: admin

 For role postgresql:
 - postgresql_user: sqladmin
 - postgresql_password: admin

## Playbooks

 - main.yml
 	- This is the default playbook, it installs only the role "common".

 - app-server.yml
 	- This playbook installs an application server with apache2 and tomcat.

 - db-server.yml
 	- This playbook installs databases on a server.

 - dev-server.yml
 	- This playbook install a development server with dev tools.


# General

For using Ansible used the documentation on: http://docs.ansible.com/ansible/latest/playbooks_best_practices.html.

## Directory Layout

This repository use the following structure

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
