#!/bin/bash

files=$(ls submissions/*.c submissions/*.py 2> /dev/null | wc -l)
if [ "$files" != "0" ]; then
    last_entry=`cd submissions && ls -w 1 *.c *.py 2> /dev/null | sort | tail -n 1 | perl -pe 's/(\d+).*\$/\$1/;'`
else
    last_entry=0
fi

let handle=$last_entry+1

printf "participant's name: "
read name

printf "language [c/py]: "
read lang

echo "$name" >> submissions/participants.txt
echo "$name $handle.$lang" >> submissions/answers.txt

printf "submission:\n"
cat > submissions/$handle.$lang
