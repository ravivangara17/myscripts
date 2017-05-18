#!/bin/bash
while read line; do
 	nc -z  $line 6379
 	nc -z  $line 16379
done < servers-redis.txt
