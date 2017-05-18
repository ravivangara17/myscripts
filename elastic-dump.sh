###
###
###copyAll.sh es.stg-1407.core.oneops.prod.walmart.com  searchdb-5674190-1-11742428.stg.core-1612.oneops.prod.walmart.com cost*
#elastic-dump.sh eslogs.mgmt-1410.core.oneops.prod.walmart.com   eslogs.mgmt1.oneops.walmart.com logstash*


#/bin/bash

if [ $# -lt 3 ]; then
    echo "Usage: elastic-dump.sh FROM_ES_HOST TO_ES_HOST INDEX_WILDCARD"
    exit
fi


from="$1"
to="$2"
indices=$(curl -s -L $from:9200/_cat/indices/$3?h=index | sed 's/\n\+/\s/g')

echo "copying index(es) from $from to $to"


for X in $indices
do
  echo "Starting index: $X"
  elasticdump \
   --input=http://$from:9200/$X \
   --output=http://$to:9200/$X \
   --type=analyzer
  elasticdump \
   --input=http://$from:9200/$X \
   --output=http://$to:9200/$X \
   --type=mapping
  elasticdump \
   --input=http://$from:9200/$X \
   --output=http://$to:9200/$X \
   --type=data --limit 5000
  echo "Done with $X"
done
