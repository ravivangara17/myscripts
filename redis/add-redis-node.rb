#!/bin/ruby
redis_ip = `redis-cli cluster nodes |grep fail | cut -d " " -f 2 | cut -d ":" -f 1`.split("\n")
hostip = `hostname -i`.split("\n")
node_fail_count  = `redis-cli cluster node | grep fail |wc -l`.split("\n")

if "#{redis_ip}" == "#{hostip}"
	puts "Hostname = redis IP"
else
	puts "hostname and redis Ip are differnt"
end


  then 
	`redis_cli add node "$hostip"
elsif
	node_fail_count  < 3 
        `redis_cli add node "$hddostip"
elif
	cluster_node_count >3 && <6
 	puts "please recreate cluster, 3 or more Masters down"
end 

