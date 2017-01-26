#!/bin/bash
#OpenVPN install script.
# Will work for Debian, Ubuntu, & CentOS

# See if the operating system is a Debian
if readlink /proc/$$/exe | grep -qs "dash"; then 
    echo  "This script has to be used with bash, not with sh. Silly!"
    exit 1
fi
