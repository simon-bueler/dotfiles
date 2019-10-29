#! /bin/bash

if [ $(nmcli -f TYPE con show --active | grep vpn | wc -l) > 0 ]
then



