#!/bin/bash

function getIssue() {
  curl \
    -X GET \
    -H "Authorization: token $token" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/begyyal/$repos/issues/$issue_no
}

function closeIssue() {
  curl \
    -X PATCH \
    -H "Authorization: token $token" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/begyyal/$repos/issues/$issue_no \
    -d '{"state":"closed"}'
}

token=$1
repos=$2
if [ -z $token -o -z $repos ]; then
  echo 'Required argument lacks.'
  exit 1
fi

git clone https://${token}@github.com/begyyal/${repos}.git

git fetch
git branch |
awk '{print substr($0,3)}' |
while read branch; do
 
  issue_no=${branch:8}
  [ -z $issue_no ] && continue

  state=$(getIssue | jq '.state')
  [ $state = closed ] && closeIssue

done
