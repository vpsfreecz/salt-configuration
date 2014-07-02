#!/bin/bash

C=$(grep -E "^c" /proc/spl/kstat/zfs/arcstats | grep -v "_" | awk {'print $3'})
C_MIN=$(cat /proc/spl/kstat/zfs/arcstats | awk '/^c_min/ {print $3}')

MEMINFO_FREE=$(cat /proc/meminfo | awk '/^MemFree/ {print $2}')
MEMINFO_TOTAL=$(cat /proc/meminfo | awk '/^MemTotal/ {print $2}')

MEM_FREE=$(( ($C - $C_MIN) + ($MEMINFO_FREE * 1024) ))
MEM_TOTAL=$(( ($MEMINFO_TOTAL * 1024) ))

echo $(( $MEM_FREE / ($MEM_TOTAL / 100) ))
