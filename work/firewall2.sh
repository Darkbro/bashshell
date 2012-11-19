#!/bin/bash
#Filename:firewall2.sh
#=================< Set Variable >==================

IPT=/sbin/iptables
MAIL_SRV=10.0.1.100
ACC_PC=192.168.0.200

#==============< Set Default Policy >===============

$IPT -t filter -P INPUT DROP
$IPT -t filter -P FORWARD DROP

#=============< Clear Original Rule >===============

$IPT -t filter -F

#================< Set INPUT Rule >=================

$IPT -A INPUT -p tcp -m state --state INVALID -j DROP
$IPT -A INPUT -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT

#=====================< Set FORWARD Rule >======================

$IPT -A FORWARD -i eth0 -o eth1 -m state --state INVALID -j DROP
$IPT -A FORWARD -i eth0
