#!/bin/bash
for shard in $(curl -XGET http://osmetricses.prod.dashboards.oneops.prod.walmart.com:9200/_cat/shards | grep UNASSIGNED | awk '{print $2}'); 
do
    curl -XPOST 'http://osmetricses.prod.dashboards.oneops.prod.walmart.com:9200/_cluster/reroute' -d '{
        "commands" : [ {
              "allocate" : {
                  "index" : "openstack-metrics-2017.03.29",
                  "shard" : $shard,
                  "node" : "10.9.249.9",
                  "allow_primary" : true
              }
            }
        ]
    }'
    sleep 5
done
