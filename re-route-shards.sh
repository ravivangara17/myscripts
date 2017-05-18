#!/bin/bash
HOST=eslogs.stg.oneops.walmart.com
PORT=9200
TO_NODE=10.247.192.210

curl "http://$HOST:$PORT/_cat/shards" | grep UNAS | grep logstash-2017.02|  awk '{print $1,$2}' | while read var_index var_shard; do 
  curl -XPOST "http://$HOST:$PORT/_cluster/reroute" -d "
    { 
      \"commands\" : [ 
        { 
          \"allocate\" : 
            { 
              \"index\" : \"$var_index\", 
              \"shard\" : $var_shard, 
              \"node\" : \"$TO_NODE\", 
              \"allow_primary\" : true 
            } 
        } 
      ]
    }" ; 
    sleep 5; 
done
