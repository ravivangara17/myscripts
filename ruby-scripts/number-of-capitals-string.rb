#!/usr/bin/env ruby
your_string = "Hello World"
capital_count = your_string.scan(/[A-Z]/).length
puts "#{capital_count}"
