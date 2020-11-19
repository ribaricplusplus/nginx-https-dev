#!/bin/bash
# Must be called from the root of the directory (nginx)

# Script that strips .m4 and changes src/ to dist/
SCRIPT=' \
{
stripSrc = substr($0, length("src/")+1)
if ($0 ~ /\.m4$/)
  {
    stripM4 = substr(stripSrc, 1, length(stripSrc) - length(".m4"))
    print "dist/" stripM4
  }
else
  {
    print "dist/" stripSrc
  }
}
'

find src -type f | awk "$SCRIPT"
