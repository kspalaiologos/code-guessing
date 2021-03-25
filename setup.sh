#!/bin/bash

yes | sudo apt install highlight rename agrep
mkdir -p submissions
mkdir -p www
echo -n "5" >> submissions/round.txt

# i wanna love you
# but i better not
touch                                submissions/answers.txt submissions/participants.txt
# i wanna hold you
# but my senses tell me to stop

g++ -O3 -march=native guessing.cpp -o guessing

echo "-------------------------------------------------------"
echo "Setup done! Be sure to adjust the number in submissions/round.txt"
echo "You can add new submissions using ./add_submission.sh"
echo "Once all the submissions are added, use ./shuffle_submissions.sh && ./make_html.sh"
echo "Then, after everyone submits their guesses, input them using ./play.sh"
echo "./play.sh will output the round's results. after you publish them, use"
echo "./next_round.sh to get a fresh environment for the next round."
