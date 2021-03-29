#!/bin/bash

highlight submissions/*.c submissions/*.py --inline-css --no-version-info -f -d www/

ROUND=`cat submissions/round.txt`

mkdir -p www/$ROUND
rm -f www/$ROUND/index.htm

cat >> www/$ROUND/index.htm <<END
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Code guessing round $ROUND</title>
<style>
h1 {
	font-size: 60px;
	margin-bottom: 20px;
}

/* 'highlight' should have emitted that, but it doesn't for some reason. */
.block {
    color: #000000;
    background-color: #e0eaee;
    font-size: 10pt;
    font-family: 'Courier New', monospace;
}

body {
    font-family: sans-serif;
    width: 50%;
    margin: auto;
}
</style>
</head>
<body bgcolor="#EEEEEE">
<h1>Code guessing, round $ROUND</h1>
<p>These files are the entries to the code guessing competition. They have been randomly shuffled.
You may skip guessing someone, but you can't guess more than one person for an entry. Incorrect
guesses don't have a point hit. If you're correctly guessed, you lose one point. If you guess
correctly, you gain one point.
<p>List of submissions:
<ul>
END

cat submissions/participants.txt | shuf | perl -pe "s/.*/\<li\>\<code\>\$&\<\/code\>\<\/li\>/;" >> www/$ROUND/index.htm

echo "</ul>" >> www/$ROUND/index.htm

for f in www/*.html; do
    u=`echo "$f" | perl -pe "s/www\/([0-9]+\.[a-zA-Z]+)\.html/\\\$1/;"`
    echo "<h2 style=\"margin-left: -20px;\">$u</h2><pre class=\"block\">" >> www/$ROUND/index.htm
    cat $f >> www/$ROUND/index.htm
    echo "</pre>" >> www/$ROUND/index.htm
done

cat >> www/$ROUND/index.htm <<END
</body>
</html>
END

rm -f www/*.html
