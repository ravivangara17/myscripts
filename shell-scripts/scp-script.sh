#!/bin/bash
while read line; do
 	scp app@$line:/home/opt/*.zip .
    echo "$line"
done < cbase-dal.txt
