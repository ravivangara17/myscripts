#!/usr/bin/env ruby


#Add new element to Array
#array.push("another string")


#last item out of array
#array.pop

b = [1, 1, 2, 2, 3, 3, 4, 4]
puts b.sort.inspect
puts b.length
puts b.first
puts b.last
puts b.uniq.inspect

my_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
even_array = my_array.each { |value| puts value if value.to_f%4==0}
puts even_array.inspect

Delete even numbers in an Array
#[1, 2, 3, 4, 5, 6].delete_if {|n| n%2 == 0 } 
#a.delete_if &:even?

#a = [1, 2, 3, 4, 5, 6]
#b = a.select {|x| x.odd? } 
