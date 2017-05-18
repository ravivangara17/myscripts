#!/bin/bash
for file in *.pcap ; do
	curl --upload-file $file  https://s3.amazonaws.com/customers.couchbase.com/walmart/
    echo "$file"
done
