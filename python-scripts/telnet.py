#!/usr/bin/env python
filename="dal-cbase-ship.txt" 
for line in open(filename, 'r'):
    teloput = nc -z %('line')
    print teloput


#fp = open('dal-cbase-ship.txt')
#while 1:
#	line = fp.readline()
#	do nc -z $line 22
#	echo $line
#
#
#!/bin/bash
#while read line; do
#        nc -z  $line 11209
#        nc -z  $line 11210
#    echo "$line"
#done < dal-cbase-ship.txt
