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

#print "Please enter Platform Text file API token: "
#@add_platform = gets.chomp
#puts "Welcome #{@add_platform}"

#print "Please enter working directory of add platform text files: "
#@working_dir = gets.chomp
#puts "Welcome #{@working_dir}"

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
#puts "#{@curl_get_cmd}"


def check_for_failure(response, request)
	if response.nil? || !$?.success?
		request == "disabling environment" ? (abort "****** failing while #{request} #{response} so aborting ******") : (abort "****** failing while #{request} #{response["errors"]} #{response} so aborting ******")
	else
		request == "disabling environment" ? (puts "****** success while #{request} ******") : (puts "****** success while #{request} #{response["errors"]} ******")
	end
end

def add_platform_design(file_name)
	puts "#{@curl_post_cmd} -d @#{file_name} https://#{@apitoken}\@#{@ooenvs}/#{@org_name}/assemblies/#{@assembly_name}/design/platforms/ 2>&1"
	response=`#{@curl_post_cmd} -d @#{file_name} https://#{@apitoken}\@#{@ooenvs}/#{@org_name}/assemblies/#{@assembly_name}/design/platforms/ 2>&1`
	if response.class=="Hash"
		response=JSON.parse(response)
	end
	check_for_failure(response, "Add Platfcrm")
end


Dir.glob("*platform.txt") do |file_name|
next if file_name == '.' or file_name == '..'
puts file_name
        for i in 1..5 do
        text = File.read(file_name)
        new_contents = text.gsub("new") { val = "new" + i.to_s; i+=1; val }
        puts new_contents
        File.open(file_name, "w") {|file| file.puts new_contents }
	add_platform_design(file_name)
        end
end

#Dir.glob("*platform.txt") do |file_name|
#next if file_name == '.' or file_name == '..'
#puts file_name
#        for i in 8..10 do
#        file_name = file_name.gsub("new") { val = "new" + i.to_s; i+=1; val }
#        #file_name = file_name.gsub(/new\d+/){|i|i.to_i+1}
#        #file_name.gsub(/(?<=new)\d+/) {|num| num.to_i+1}
#        puts file_name
##	add_platform_design(file_name)
#        end
#end
#Dir.glob("*platform.txt") do |file_name|
#next if file_name == '.' or file_name == '..'
#puts file_name
#	until $i > $num  do
#   	puts("Inside the loop i = #$i" )
#   	`sed -i -- 's/new/new$i/g'|file_name|`
#	end
#end

#files.each do |file_name|
#  if !File.directory? file_name
#    add_platform_design(file_name)
#    end
#end

#  end
#add_platform_design

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
