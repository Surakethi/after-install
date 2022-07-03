#!/bin/bash

### Your default information
SUDO_USER='widiastono'
TIMEZONE='Asia/Jakarta'
PORT_SSH=2277
export DEBIAN_FRONTEND=noninteractive

### update & upgrade debian
apt-get update -y
apt-get upgrade -y

### install needed application
apt-get install net-tools ntp sysstat iptraf traceroute tcptraceroute pktstat bwm-ng whois httperf mailutils lynx \
nast dsniff build-essential tcpdump sudo curl vim dnsutils -y

### adding SUDO_USER to sudo group
usermod -a -G sudo $SUDO_USER

### setup ntp client
if ! grep -q '### ID NTP' /etc/ntp.conf
then
	echo "### ID NTP" >> /etc/ntp.conf
	sed -i '18r ntp-id.conf' /etc/ntp.conf
else
	echo -e "ntp config updated"
fi

mv /etc/localtime /etc/localtime.old
ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime


### setup ssh server
sed -i 's/#Port 22$/Port '$PORT_SSH'/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
if ! grep -q 'UseDNS no' /etc/ssh/sshd_config
then
	echo 'UseDNS no' >> /etc/ssh/sshd_config
fi

### disable uneeded services
service exim4 stop
update-rc.d -f exim4 remove
service rpcbind stop
update-rc.d -f rpcbind remove

### remove exim4
apt purge -y exim4-config exim4-daemon-light
