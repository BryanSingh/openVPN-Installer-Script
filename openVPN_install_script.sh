#!/bin/bash
#OpenVPN install script.
# Will work for Debian, Ubuntu, & CentOS

# See if the operating system is a Debian
if readlink /proc/$$/exe | grep -qs "dash"; then 
    echo  "This script has to be used with bash, not with sh. Silly!"
    exit 1
fi

if [[ "$EUID" -ne 0 ]]; then 
    echo "Well ... seems like you are not a root user. Try again when you have the correct privilages"
    exit 2
fi

if [[ ! -e /dev/net/tun ]]; then
    echo "TUN is not aviable"
    exit 3
fi

if grep -qs "CentOS release 5" "/etc/redhad-release"; then
    echo "CentOS 5 is too old to be using here. I can't make it work sadly :( "
    exit 4
fi

if [[ -e /etc/debian_version ]]; then
    OS=debian
    GROUPNAME=nogroup
    RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
    OS=centos
    GROUPNAME=nobody
    RCLOCAL='/etc/rc.d/rc.local'
        # If I am not mistaken, this is needed for CentOS 6? ...
    chmod +x /etc/rc.d/rc.local
else
    echo "Huh, not on a Debian or a CentOS system"
    exit 5
fi

newclient() {
    # will create a custom client.opvn
    cp /etc/openvpn/client-cmmon.txt ~/$1.opvn
