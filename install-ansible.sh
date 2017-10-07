#!/bin/bash

# add current user to sudoers
if ! sudo test -f "/etc/sudoers.d/$USER"; then
	echo "$USER ALL=NOPASSWD:ALL" | sudo tee "/etc/sudoers.d/$USER" > /dev/null
	sudo chmod 440 /etc/sudoers.d/$USER
	echo "sudo password question disabled"
fi

# install Ansible
if ! [ -f "/usr/bin/ansible" ]; then
	sudo apt-get update
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible
fi

# setup ssh-key
if ! [ -f "/home/$USER/.ssh/id_rsa" ]; then
	mkdir ~/.ssh
	chmod 700 ~/.ssh
	ssh-keygen -q -t rsa
	echo "ssh key created"

	# copy ssh-key for localhost
	ssh-copy-id $USER@localhost
fi
