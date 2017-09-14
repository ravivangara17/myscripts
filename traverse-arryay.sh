#!/bin/bash
array=( apple bat cat dog elephant frog )
#print first element
echo ${array[0]}
echo ${array:0}

#display all elements 
echo ${array[@]} 
echo ${array[@]:0} 

#display elements in a range 
echo ${array[@]:1:4} 
#length of first element 
echo ${#array[0]} 
echo ${#array} 
#number of elements 
echo ${#array[*]} 
echo ${#array[@]} 
#replacing substring 
echo ${array[@]//a/A} 



#read -a array4
#for i in "${array4|@|}"
#do
#echo $i
#done 
exit 0

#Command substitution with array
array=( $(command) )


#print the whole bash array
echo ${Unix[@]}
echo #{#Unix[@]}
