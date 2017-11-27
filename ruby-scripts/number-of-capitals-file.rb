#!/usr/bin/env ruby
total = 0
File.open('test.txt').each do |line|
	capital_count = line.scan(/[A-Z]/).length
	puts "#{capital_count}"
end
#puts "#{capital_count}"
#your_string = "Hello World"
#capital_count = your_string.scan(/[A-Z]/).length
#puts "#{capital_count}"
