#!/usr/bin/env ruby

require 'json'

# OneOps End Point
cms_api = 'http://cms.prod-1312.core.oneops.prod.walmart.com:8080'
#cms_api = 'http://cms.stg-1407.core.oneops.prod.walmart.com:8080'


# All cloud relations from platform
#pack = 'node'
pack = 'kubernetes'
#pack = 'tomcat'
#pack = 'oracle'
#pack = 'redisio'
#pack = 'nodejs'
#pack = 'nexus'
#pack = 'rabbitmq'
#pack = 'mysql'
#pack = 'javalb'
#pack = 'haproxy'
#pack = 'ecpipeline'
#pack = 'javaws'
#pack = 'custom'
#pack = 'enterprise-server'
#pack = 'wmt_jboss'

rels = JSON.parse(`curl -sg "#{cms_api}/adapter/rest/cm/simple/cis?nsPath=/&ciClassName=catalog.Platform&recursive=true&attr=pack:eq:#{pack}"`)

rels.sort { |a, b| a['ciAttributes']['source'] <=> b['ciAttributes']['source'] }.each { |rel|
  puts "Pack: #{rel['ciAttributes']['pack']}, Source: #{rel['ciAttributes']['source']}, nsPath: #{rel['nsPath']}, Created By: #{rel['createdBy']}"
}

