#!/usr/bin/env ruby
array1 = ["google"]
array2 = ["gle", "goo", "ole", "abb"]


array2.each do |string|
	if array1.any? { |w| w.include? string}
	puts "present"
	else
	puts "NO"
	end
end

#array2.each do |string|
# if array1.grep(/string/).empty?
#	puts "#{string}"
#	puts "present"
#  else
#	puts  "empty"
# end
#end
#array1 = ['a', 'b', 'c', 'd', 'e']
#@array2 = ['d', 'e', 'f', 'g', 'h']
#@intersection = @array1 & @array2
#@intersection should now be ['d', 'e'].

#Intersection—Returns a new array containing elements common to the two arrays, with no duplicates.
#
#You can even try some of the ruby tricks like the following :
#array1 = ["x", "y", "z"]  
#array2 = ["w", "x", "y"]  
#array1 | array2 # Combine Arrays & Remove Duplicates(Union)  
#=> ["x", "y", "z", "w"]  
#array1 & array2  # Get Common Elements between Two Arrays(Intersection)  
#=> ["x", "y"]  


#array1 - array2  # Remove Any Elements from Array 1 that are 
                 # contained in Array 2 (Difference)  
#=> ["z"]  
