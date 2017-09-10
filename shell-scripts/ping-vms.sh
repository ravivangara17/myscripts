#!/bin/bash
iplist=$
{2:-"prod-iplist.txt"}
echo $iplist
cat $
{iplist}
|while read line
do
server=$( echo "$line" | cut -d ' ' -f1 )
echo $server
ip=$( echo "$line" |cut -d ' ' -f2 )
echo $ip
purpose=$( echo "$line" |cut -d ' ' -f3 )
echo $purpose
ping -c 3 $server > /dev/null 2>&1
if [ $? -ne 0 ]; then
echo "ATTENTION: Server $
{ip}
has not responded to ping command at `date +"%d-%m-%y"` " >/tmp/message.txt
xargs -a email.txt mail -s "[$
{env}
] $
{purpose}
server $
{server}
is down" </tmp/message.txt
fi
done
