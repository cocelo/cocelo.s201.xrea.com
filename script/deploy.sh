#!/bin/sh
#
# Require Environment.
#   ${TOKEN}    - Github Token.
#   ${FTP_SITE} - Mirror FTP Site.
#   ${FTP_USER} - Mirror FTP Username.
#   ${FTP_PASS} - Mirror FTP Password.
#

hugo

git add -A && git commit -m "Updating site" && git push -q origin deploy
git subtree push -P public "https://${TOKEN}@github.com/cocelo/cocelo.s201.xrea.com.git" master

lftp -e "set ssl:verify-certificate no; mirror -Rev --ignore-time -P 2 -x .git public public_html; exit" -u ${FTP_USER},${FTP_PASS} ${FTP_SITE}
