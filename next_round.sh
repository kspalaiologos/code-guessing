#!/bin/bash

# Strawberry pie
# Pumpkin pie
perl -pi -e '$_++' submissions/round.txt
# Creampie!

cd submissions && rm -f *.c *.py answers.txt participants.txt \
    && touch answers.txt participants.txt && cd ..

