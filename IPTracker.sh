#! /bin/bash
# Comment Line
function sendMail
{
    mail - s "IP" entegre95@gmail.com < mail.txt
}

function IPMovements
{
    echo "Disconnected IPs" > mail.txt
    diff firstIPControl.txt secondIPControl.txt | grep '<' >> mail.txt
    echo "Connected IPs" >> mail.txt
    diff firstIPControl.txt secondIPControl.txt | grep '>' >> mail.txt
    sendMail
}

# cat file1.txt>>file2.txt

function firstIPControl
{
    nmap -sn 192.168.47.0/24 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' > firstIPControl.txt
    while read line 
    do
        IPTemp="$line"
        ex -s +"g/$IPTemp/d" -cwq firstIPControl.txt
    done < IPLib.txt
}

function secondIPControl
{
    nmap -sn 192.168.47.0/24 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' > secondIPControl.txt
    while read line 
    do
        IPTemp="$line"
        ex -s +"g/$IPTemp/d" -cwq secondIPControl.txt
    done < IPLib.txt
}

function firstStart
{
    numberOfFindedLine=$(grep -c '1' firstIPControl.txt)

    if [ "$numberOfFindedLine" != 0 ]
    then
        secondIPControl
        IPMovements
    fi
}

#First Start Check
ls firstIPControl.txt && firstStart ||{ echo "Creating..."
    > firstIPControl.txt
}

#Checking NMAP
nmap -sn 192.168.47.113 ||{ echo "nmap is not found... installing..." 
    sudo apt-get install nmap
}

#Infinite Control Loop
while :
do
    firstIPControl
    sleep 3600s 
    secondIPControl
    IPMovements  
done