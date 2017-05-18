#!/usr/bin/env ruby

require 'json'

data = JSON.parse(ARGF.read)

if data.include?('raw_data')
  puts JSON.pretty_generate(data['raw_data'])
else
  puts JSON.pretty_generate(data)
end
