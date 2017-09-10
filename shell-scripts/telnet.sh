#!/bin/bash
while read line; do
 	nc -z  $line 11209
 	nc -z  $line 11210
    echo "$line"
done < dal-cbase-ship.txt
