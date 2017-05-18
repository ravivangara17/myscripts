#!/usr/bin/env ruby
#echo USAGE:- ruby kill XXXXX.rb where XXXX = Deployment Number/ID
require 'curb'
require 'json'
cms_api = "http://cms.prod-1312.core.oneops.prod.walmart.com:8080"
#cms_api = "http://localhost:8080"
dpmt_id = ARGV[0]
drs = JSON.parse(`curl -s "#{cms_api}/kloopz-cms-api/rest/dj/simple/deployments/#{dpmt_id}/cis?state=inprogress"`)
drs.each do |dr|
puts "dr: #{dr.inspect}"
dr["dpmtRecordState"] = "canceled"
c = Curl::Easy.http_put(cms_api + "/kloopz-cms-api/rest/dj/simple/deployments/#{dpmt_id}/records" , JSON.dump(dr)) do |curl|
curl.headers['Accept'] = 'application/json'
curl.headers['Content-Type'] = 'application/json'
end
puts "resp: "+c.body_str
end
c = Curl::Easy.http_get(cms_api + "/kloopz-cms-api/rest/dj/simple/deployments/#{dpmt_id}/cancel")
puts "resp: "+c.body_str
