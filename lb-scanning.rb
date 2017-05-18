require "json"
require "base64"
require 'excon'
require 'ipaddress'

ns_user = "oneops"
ns_passwd = "XXXXXXX"


def gen_conn(username, password ,host)
  encoded = Base64.encode64("#{username}:#{password}").gsub("\n","")
  conn = Excon.new(
    'https://'+host, 
    :headers => {
      'Authorization' => "Basic #{encoded}", 
      'Content-Type' => 'application/x-www-form-urlencoded'
    },
    :ssl_verify_peer => false)
   return conn  
end

netscalers = {
	"dfw" => {
		"2b" =>  "10.65.74.7",
		"2c" =>  "10.65.74.24"
	},
	"dal" =>  {
		"2b" => "10.65.202.7",
		"2d" => "10.65.202.31"
	}
}



netscalers = {
        "dfw" => {
                "2b" =>  { "ip" => "10.65.74.7", 
                	"range" => "10.65.80.0/22,10.65.85.0/24,10.65.86.0/24,10.65.87.0/24,10.65.67.0/24,10.65.62.0/24" 
                	},
                "2d" =>  { "ip" => "10.65.74.24",
                	"range" => "10.247.214.16/28,10.247.214.32/27,10.247.214.64/26,10.247.214.128/25" 
                }
        },
        "dal" =>  {
                "2b" => { 
                	"ip" => "10.65.202.7", 
                	"range" => "10.65.208.0/22,10.65.213.0/24,10.65.214.0/24,10.65.215.0/24,10.65.222.0/24,10.65.195.0/24,10.65.198.0/24" 
                	},
                "2d" => { 
                	"ip" => "10.65.202.31", 
                	"range" => "10.247.150.16/28,10.247.150.32/27,10.247.150.64/26,10.247.150.128/25" 
                }
        }
}

oneops_vip_details = []
netscalers.each do |cloud,cloud_details|
	#puts cloud.inspect
	#puts cloud_details.inspect
	cloud_details.each do |zone, zone_detail|
		oneops_vips = {}
		#puts "Getting details for Cloud #{cloud} for zone #{zone}"
		ns_conn = gen_conn(ns_user, ns_passwd, zone_detail['ip'])
		#puts ns_conn.inspect
		resp_obj = JSON.parse(ns_conn.request(
			:method=>:get,
			:read_timeout => 300,
			:path=>"/nitro/v1/config/lbvserver").body)
		lbs = resp_obj["lbvserver"]
		total_available_ips = 0
		zone_detail['range'].split(",").each do |range|
			ip = IPAddress::IPv4.new(range)
		#	total_available_ips += ip.length
			ip.each do |i|
				total_available_ips += 1
				ipstr = i.to_s
				lbs.each do |lb|
					if lb["ipv46"] == ipstr
						#oneops_vips << {:lbvserver_name => "#{lb['name']}", :lbvserver_ip => "#{lb["ipv46"]}"}
						if oneops_vips["#{lb['ipv46'].to_str}"].nil?
							oneops_vips["#{lb['ipv46'].to_str}"] = ["#{lb['name']}"]
						else
							oneops_vips["#{lb['ipv46'].to_str}"].push("#{lb['name']}")
						end
					end
				end
			end
		end
#		puts "netscaler:#{zone_detail['ip']} zone:#{zone} available:#{total_available_ips} oneops_consumed:#{oneops_vips.keys.length} available:#{total_available_ips-oneops_vips.keys.length}"
		oneops_vip_details << {:cloud => "#{cloud}", :netscaler => "#{zone_detail['ip']}", :zone => "#{zone}", :consumed => "#{oneops_vips.keys.length}", :available => "#{total_available_ips-oneops_vips.keys.length}"}
	end
end

puts oneops_vip_details.inspect
