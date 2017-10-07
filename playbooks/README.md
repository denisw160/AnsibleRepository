# Using Ansible for automation

## Execute commands (without playbook)
For example: Test and setup the nodes with ansible requirements (see python).

```
	$ ansible dockers [-u remote-user] -m raw -a "echo hello"
	$ ansible dockers [-u remote-user] --become --become-user=root --ask-become-pass -m raw -a "apt install -y python-simplejson"
	$ ansible dockers [-u remote-user] -m ping
```

# Playbook

## Upgrading servers
This playbook upgrades all servers and restarted the servers.

```
	$ ansible-playbook [-u remote-user] --extra-vars "hosts=group" --ask-become-pass upgrade-restart.yml
```

## Shutdown servers
This playbook shutdown the server group.

```
	$ ansible-playbook [-u remote-user] --extra-vars "hosts=group" --ask-become-pass shutdown.yml
```
