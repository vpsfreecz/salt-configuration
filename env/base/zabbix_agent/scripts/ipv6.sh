#!/usr/bin/env bash

IP6=$(ip -6 r s | grep default)

if [[ ! -z "$IP6" ]]; then
    echo 1
else
    echo 0
fi
