#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'fog'
require 'json'
require "base64"
require 'excon'
require 'net/http'

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

@curl_get_cmd="curl -X GET -k -H 'Content-Type: application/json' -H 'Accept: application/json'"
@curl_post_cmd="curl -X POST -k -H 'Content-Type: application/json' -H 'Accept: application/json'"
@curl_put_cmd="curl -X PUT -k -H 'Content-Type: application/json' -H 'Accept: application/json'"
@curl_delete_cmd="curl -X DELETE -k -H 'Content-Type: application/json' -H 'Accept: application/json'"

def check_for_failure(response, request)
	if response.nil? || !$?.success?
		request == "disabling environment" ? (abort "****** failing while #{request} #{response} so aborting ******") : (abort "****** failing while #{request} #{response["errors"]} #{response} so aborting ******")
	else
		request == "disabling environment" ? (puts "****** success while #{request} ******") : (puts "****** success while #{request} #{response["errors"]} ******")
	end
end

def get_open_release_design()
        response=`#{@curl_get_cmd} https://#{@apitoken}\@#{@ooenvs}/#{@org_name}/assemblies/#{@assembly_name}/design/releases/latest 2>&1`
        if response.class=="Hash"
                response=JSON.parse(response)
                puts "#{response}"
        end
        check_for_failure(response, "GET open releases")
                puts "#{response}"
end

get_open_release_design
