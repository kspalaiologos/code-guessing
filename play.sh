#!/bin/bash

# the
cat | perl -pe 's/[^0-9]*(\d*)[^A-Za-z]*([A-Za-z0-9]+)/$1 $2/g;' \
    | sort | awk '{print $2}' | perl -pe '`agrep -B "$_" "submissions/participants.txt"`' \
    | ./guessing 2> script.log
# is purring, it scratches my skin. So what is wrong with another sin?
