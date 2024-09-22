#!/bin/bash
echo "Please enter the number till then you want to display even numbers"
read number

echo "Below are the even numbers till the $number you entered here:"
for((i=1; i<=$number; i++))
do
if [ $((i%2)) == 0 ]
then
echo "Even number is $i"
fi

done