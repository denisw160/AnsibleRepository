Raspberry Pi 5110 Mini LCD
======

This Mini LCD screen display the CPU utilization and the memory occupancy rate that 
runs your Raspberry Pi.

More on: http://www.sunfounder.com/wiki/index.php?title=Raspberry_Pi_5110_Mini_LCD_84*48_PCD8544_Usage

# Installation 

Installation of cpu_show for C programmer.

**Step 1**: Install wiringPi
```
	$ cd /opt
	$ git clone git://git.drogon.net/wiringPi
	$ cd wiringPi
	$ ./build
```

**Step 2**: Download Cpu_show.tar.gz to /opt and extract it
```
	$ cd /opt
	$ wget https://www.sunfounder.com/wiki/images/5/5b/Cpu_show.tar.gz
	$ tar xvf Cpu_show.tar.gz
	$ rm Cpu_show.tar.gz
```
	
**Step 3**: Compile files
```
	$ cd /opt/cpu_show
	$ ./compile.sh
```

**Step 4**: Install init script
```
	$ cd /etc/init.d
	$ wget https://raw.githubusercontent.com/denisw160/RancherDockerRepository/master/other/raspberry-pi-5110-mini-lcd/cpu_show
	$ chmod 755 cpu_show
	$ [Add cpu_show as service, e.g.
	$ update-rc.d cpu_show defaults
	$ update-rc.d cpu_show enable]
```	
