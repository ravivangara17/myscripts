#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'fog'
require 'json'
require 'base64'
require 'excon'
require 'net/http'
require 'json'

print "Please enter your API token: "
@apitoken = gets.chomp
puts "Welcome #{@apitoken}"

print "Please enter ORG name: "
@org_name = gets.chomp
puts "Welcome #{@org_name}"

print "Please enter Assembly Name: "
@assembly_name = gets.chomp
puts "Welcome #{@assembly_name}"

# OneOps endpoints
@ooenvs="oneops.stg.walmart.com"
puts "Welcome #{@ooenvs}"

@curl_get_cmd="curl -s -X GET -k -H 'Content-Type: application/json' -H 'Accept: application/json'"
@curl_post_cmd="curl -s -X POST -k -H 'Content-Type: application/json' -H 'Accept: application/json'"
@curl_put_cmd="curl -s  -X PUT -k -H 'Content-Type: application/json' -H 'Accept: application/json'"
@curl_delete_cmd="curl -s -X DELETE -k -H 'Content-Type: application/json' -H 'Accept: application/json'"

def check_for_failure(response, request)
	if response.nil? || !$?.success?
	 	abort "****** failing while #{request} #{response} so aborting ******"
	else
		puts "****** success while #{request} ******"
	end
end

def get_open_release_design()
        response=JSON.parse(`#{@curl_get_cmd} https://#{@apitoken}\@#{@ooenvs}/#{@org_name}/assemblies/#{@assembly_name}/design/releases/latest 2>&1`)
	puts response.class
	puts response
	@releaseid = response["releaseId"]
end

get_open_release_design

puts @releaseid

def commit_release_design()
	cmt_resonse_cmd="#{@curl_post_cmd} https://#{@apitoken}\@#{@ooenvs}/#{@org_name}/assemblies/#{@assembly_name}/design/releases/#{@releaseid}/commit 2>&1"
	puts "#{cmt_resonse_cmd}"
        cmt_response=JSON.parse(`#{@curl_post_cmd} https://#{@apitoken}\@#{@ooenvs}/#{@org_name}/assemblies/#{@assembly_name}/design/releases/#{@releaseid}/commit 2>&1`)
	puts cmt_response.class
	puts cmt_response
end
commit_release_design
