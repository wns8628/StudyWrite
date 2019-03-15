#! /bin/bash

echo '################### more /etc/redhat-release ########################'
more /etc/redhat-release
echo
echo
echo

echo '######################### uname -r ###############################'
uname -r
echo
echo
echo

echo '######################### uname -a ###############################'
uname -a
echo
echo
echo

echo '######################### getconf WORD_BIT ################################'
getconf WORD_BIT
echo
echo
echo

echo '######################### hostid ################################'
hostid
echo
echo
echo

echo '######################### /sbin/ifconfig -a ################################'
/sbin/ifconfig -a
echo
echo
echo

echo '######################### netstat -na |grep LISTEN ################################'
netstat -na | grep LISTEN
echo
echo
echo

echo '######################### netstat -na ################################'
netstat -na
echo
echo
echo

echo '######################### netstat -nr ################################'
netstat -nr
echo
echo
echo

echo '######################### hostname ################################'
hostname
echo
echo
echo

echo '######################### more /etc/hosts ################################'
more /etc/hosts
echo
echo
echo

echo '######################### more /etc/passwd ################################'
more /etc/passwd
echo
echo
echo

echo '######################### more /etc/group ################################'
more /etc/group
echo
echo
echo

echo '######################### more /etc/shadow ################################'
more /etc/shadow
echo
echo
echo

echo '######################### ls -alR /etc/pam.d ################################'
ls -alR /etc/pam.d
echo
echo
echo

echo '######################### df -Ha ################################'
df -Ha
echo
echo
echo

echo '######################### more /etc/fstab ################################'
more /etc/fstab
echo
echo
echo

echo '######################### ps -ef ################################'
ps -ef
echo
echo
echo

echo '######################### ps aux ################################'
ps aux
echo
echo
echo

echo '######################### pstree ################################'
pstree
echo
echo
echo

echo '######################### uptime ################################'
uptime
echo
echo
echo

echo '######################### more /boot/grub/grub.conf ################################'
more /boot/grub/grub.conf
echo
echo
echo

echo '######################### more /proc/cpuinfo ################################'
more /proc/cpuinfo
echo
echo
echo


echo '######################### free ################################'
free
echo
echo
echo

echo '######################### sestatus ################################'
sestatus
echo
echo
echo

