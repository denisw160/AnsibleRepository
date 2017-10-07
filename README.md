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


