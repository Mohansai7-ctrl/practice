#!/bin/bash

file=$1
searchword=$2

USAGE (){

    echo "USAGE: sh scriptname <filename> <search_word> "
}

if [ $# -lt 2 ]
then
    USAGE
    exit 1
fi

if [ ! -f $1 ]
then 
    echo "file not exists"
    exit 1
else
    echo "$1 exists"
fi

#while IFS= read -r line
#do
#    echo "searching lines: $file"
#count=$(cat $file | grep $searchword | wc -w)
#echo "$searchword=$count"
#done <<<$file


awk '{ for (i=1; i<=NF; i++) words[$i]++ } END { for (word in words) print word, words[word] }' "$file" |
sort -k2,2nr -k1,1 |
# Filter out words with count less than or equal to 1
awk '$2 > 1 { print }'
