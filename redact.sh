#!/usr/bin/env sh

# Usage:
#   redact.sh [words.txt] < confidential.txt
#
# Given a confidential text file on stdin, replace all instances of private words
# with <F>—— where <F> is the first letter of the word. Private words are defined
# in a file, one per line. The file name can be given as an argument, or
# `.badwords` in the current directory will be used.

CMDS=$(
  while read -r word; do
    [ "$word" ] || continue
    suff=${word#?}
    pre=${word%"$suff"}
    echo "s/($pre)$suff/\1------/g"
  done < "${1:-.badwords}"
)

sed -E "$CMDS"