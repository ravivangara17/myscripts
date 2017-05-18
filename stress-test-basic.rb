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

# OneOps endpoints
@ooenvs="oneops.stg.walmart.com"
puts "Welcome #{@ooenvs}"

@curl_get_cmd="curl -X GET -k -H 'Content-Type: application/json' -H 'Accept: application/json'"
@curl_post_cmd="curl -X POST -k -H 'Content-Type: application/json' -H 'Accept: application/json'"
@curl_put_cmd="curl -X PUT -k -H 'Content-Type: application/json' -H 'Accept: application/json'"
@curl_delete_cmd="curl -X DELETE -k -H 'Content-Type: application/json' -H 'Accept: application/json'"
puts "#{@curl_get_cmd}"


def check_for_failure(response, request)
	if response.nil? || !$?.success?
		request == "disabling environment" ? (abort "****** failing while #{request} #{response} so aborting ******") : (abort "****** failing while #{request} #{response["errors"]} #{response} so aborting ******")
	else
		request == "disabling environment" ? (puts "****** success while #{request} ******") : (puts "****** success while #{request} #{response["errors"]} ******")
	end
end

def get_organization()
	puts "actual command is: #{@curl_get_cmd} https://#{@apitoken}\@#{@ooenvs}/dbaas/clouds/ 2>&1"
	response=`#{@curl_get_cmd} https://#{@apitoken}\@#{@ooenvs}/dbaas/clouds/ 2>&1`
	if response.class=="Hash"
		response=JSON.parse(response)
		puts "#{response}"
	end
	check_for_failure(response, "GET ORGLIST")
		puts "#{response}"
end

get_organization


#Extract Design Yaml
#https://oneops.stg.walmart.com/stgqe/assemblies/usoms/design/extract.yaml

#LOAD design yaml
#https://oneops.stg.walmart.com/stgqe/assemblies/ravitest403/design/load

#curl -X POST -k -H 'Content-Type: application/json' -H 'Accept: application/json’ -d  {“data”:”/ravi/test.yaml”} https://USERNAME@oneops.stg.walmart.com/stgqe/assemblies/ravitest403/design/load
#usom://<your-server>/<ORGANIZATION-NAME>/assemblies/<ASSEMBLY-NAME>/design/platforms
#curl -v -X POST -k -H 'Content-Type: application/json' -H 'Accept: application/json' -d @add-platform.txt https://Nc12qY4UweYBKyesqyRf@oneops.stg.walmart.com/stgqe/assemblies/ravitest403/design/tomcat


#working - add platform in design
#curl -v -X POST -k -H 'Content-Type: application/json' -H 'Accept: application/json' -d @add-platform.txt https://Nc12qY4UweYBKyesqyRf@oneops.stg.walmart.com/stgqe/assemblies/ravitest403/design/platforms/
#add-platform.txt file
#{
#    "cms_dj_ci": {
#        "comments": "",
#        "ciName": "tomcatnew",
#        "ciAttributes": {
#            "source": "walmartlabs",
#            "description": "tomcat platform",
#            "major_version": "1",
#            "pack": "tomcat",
#            "version": "1"
#        }
#    }
#}


#152446342
#working COMMIT
#curl -v -X POST -k -H 'Content-Type: application/json' -H 'Accept: application/json' https://Nc12qY4UweYBKyesqyRf@oneops.stg.walmart.com/stgqe/assemblies/ravitest403/design/releases/152446342/commit/

#{ “ciname”: “abc”, “ciId”: “1234”}
#puts response[“ciname"]
#puts response[0][“ciname"]
