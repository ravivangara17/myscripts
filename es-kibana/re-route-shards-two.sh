#!/bin/bash
for shard in $(curl -XGET http://clustername:9200/_cat/shards | grep UNASSIGNED | awk '{print $2}'); 
do
    curl -XPOST 'http://clustername:9200/_cluster/reroute' -d '{
        "commands" : [ {
              "allocate" : {
                  "index" : "INDEX NAME",
                  "shard" : $shard,
                  "node" : "NODEIP",
                  "allow_primary" : true
              }
            }
        ]
    }'
    sleep 5
done
