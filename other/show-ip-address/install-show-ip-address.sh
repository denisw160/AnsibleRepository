#!/bin/bash

# Create a copy of the current issue
cp /etc/issue /etc/issue-standard

# Install a script to the ip-address on if-up
cat >> /etc/rc.local << EOL
#!/bin/sh

# Show ip address on console
IP_ADDR=\$(/sbin/ifconfig | grep "inet " | grep -v "127.0.0.1")

# Only run for real interfaces
#if [ "\$METHOD" = loopback ]; then
#  exit 0
#fi
# Only run from ifup.
#if [ "\$MODE" != start ]; then
#  exit 0
#fi

# Create new issue with ip address
cp /etc/issue-standard /etc/issue
echo "IP-Address is" >> /etc/issue
echo \$IP_ADDR >> /etc/issue
echo "" >> /etc/issue
EOL

# Set execution flag for the script
chmod 755 /etc/rc.local

# Finished
echo Install completed

# Debug
#cat /etc/rc.local
#ls -l /etc/rc.local



