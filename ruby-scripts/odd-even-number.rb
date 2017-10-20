
#!/usr/bin/env ruby

print "Enter a starting number: "
num = Integer(gets)
i = num
loop do
i -= 1
next if i % 2 == 1
puts "#{i}"
break if i <=2
end
