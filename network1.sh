#!/bin/bash
tx_after=`ifconfig eth0|sed -n "8"p|awk '{print $6}'|cut -c7-`
echo " $tx_after"
sleep 2
dx_after=`ifconfig eth0|sed -n "8"p|awk '{print $6}'|cut -c7-`
echo " $dx_after"
