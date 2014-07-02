#!/bin/bash 

echo  $(( 100 - $(/usr/bin/sudo /sbin/zpool get capacity vz | awk '/NAME/ { getline; gsub(/%/,"",$3); print $3; }') ))
