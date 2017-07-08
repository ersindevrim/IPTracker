#! /bin/bash
# Comment Line
check="y"

while [ $check == "y" ];
do
    read -p "Please Insert Trusted IP : " trustedIP
    echo $trustedIP >> IPLib.txt
    read -p "IP added Trusted IP list. Do you want to continue IP entry? (y/n)" check
    check="${check,,}" #converting lowercase
done