#!/usr/bin/env ruby
File.readlines('test.txt').reverse_each{ |s|
   puts s
}
