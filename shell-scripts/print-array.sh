#! /bin/bash
set -e 
Unix[0]='Debian'
Unix[1]='Red hat'
Unix[2]='Ubuntu'
Unix[3]='Suse'

echo ${Unix[1]}
declare -a flavors=('Debian' 'Red hat' 'Suse' 'Fedora');
echo ${#flavors[@]} #Number of elements in the array
echo ${#flavors}  #Number of characters in the first element of the array.i.e Debian

#take first 3 elements of array and find the highest and then next three and
#so and so forth
#array {2,1,1,2,0,1,1}
#total number of elements in an array = last
#for i in 1 to i print element i
Fruits=(Apple Mango Orange Banana Grapes Watermelon);
last=`echo ${#Fruits[@]}`
# This FOR loop print 3 elements at a time 
for ((i = 0; i <= $last; i += 1))
do
echo ${Fruits[@]:$i:3}
done
