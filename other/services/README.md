# Systemd Services 

This folder includes various service descriptions for some applications.
To install the service add the file unter /etc/systemd/system. 
Then use the following commands

1. Reload all service files

  $ systemctl daemon-reload

1. Start and enable the service

  $ systemctl start gogs
  $ systemctl enable gogs
