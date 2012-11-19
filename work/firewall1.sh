#!/bin/bash
#Filename:firewall1.sh
#==================< Set Variable >========================

IPT=/sbin/iptables
SERVER=192.168.0.1
PARTNER=192.168.0.200

#===============< Clear Original Rule >====================

iptables -t filter -F

iptables -P INPUT DROP

#=================< Set INPUT Rule >=======================

$IPT -A INPUT -p tcp -m state --state INVALID -j DROP
$IPT -A INPUT -p tcp -d $SERVER --dport 25 -j ACCEPT
$IPT -A INPUT -p tcp -d $SERVER --dport 80 -j ACCEPT
$IPT -A INPUT -p tcp -d $SERVER --dport 110 -j ACCEPT
$IPT -A INPUT -p tcp -s $PARTNER -d $SERVER --dport 22 -j ACCEPT
$IPT -A INPUT -p tcp -s $PARTNER -d $SERVER --dport 23 -j ACCEPT
$IPT -A INPUT -p tcp -m state --state ESTABLISHED,RELATED  -j ACCEPY
