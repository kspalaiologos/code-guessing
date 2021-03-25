#!/bin/bash

cd submissions

rm -f shuffled.txt

l=`ls -w 1 *.c *.py 2> /dev/null | sort | tail -n 1 | perl -pe 's/(\d+).*\$/\$1/;'`
s=`seq 1 $l | shuf`
a=($(echo "$s"))

for ((i=1;i<=$l;i++)); do
    let p=$i-1
    e=${a[$p]}
    echo "$i => $e" >> "shuffled.txt"
    rename s/[0-9]+/T$e/ $i.*
done

rename "s/T//" *
