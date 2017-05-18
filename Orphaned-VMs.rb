#!/usr/bin/env ruby
 
force = ARGV[0] == 'force' ? true : false
 
rows = `nova list`.to_s.split("\n")
 
rows.each do |row|
  if row =~ /([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}) \| (.*?-\d+)\s/
    uuid = $1
    host = $2
  else
    next
  end
  if host =~ /-(\d+$)/
    ci_id = $1
  end
  result = `curl -I -s -X GET http://cmsapi.prod-1312.core.oneops.prod.walmart.com:8080/adapter/rest/dj/simple/cis/#{ci_id} | head -1`
  if result.to_s.include? "200"
    puts "ok #{host}"
  else
    puts "bad #{host}"
    puts "nova delete #{uuid}"
  end
 
end
