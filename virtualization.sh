#!/bin/bash

## virtualization.sh v1.0
## Copyright 2018, ClearCenter
## Script licensed under GNU AFFERO GENERAL PUBLIC LICENSE v3
## https://www.gnu.org/licenses/agpl-3.0.en.html
## DESCRIPTION:
## This script provisions ClearOS servers with KVM virtualization and then reboots the server
## VERSION:
## This version is known to work with ClearOS 7.5 installations.

yum install kvm virt-manager libvirt seabios-bin

mkdir -p /usr/lib/udev/rules.d
touch /usr/lib/udev/rules.d/82-kvm-clearos.rules
echo 'KERNEL=="kvm", NAME="%k", GROUP="kvm", MODE="0660"' > /usr/lib/udev/rules.d/82-kvm-clearos.rules

cat << __EOF__ > /etc/dnsmasq.d/libvirt.conf
#bind-interfaces
bind-dynamic
#except-interface=vibr0
__EOF__

systemctl start libvirtd.service
systemctl enable libvirtd.service

reboot
