#!/bin/bash

readonly BRANCH_PREFIX=feature

function getIssue() {
  curl \
    -X GET \
    -H "Authorization: token $token" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/$repos/issues/$issue_no
}

token=$1
repos=$2
if [ -z $token -o -z $repos ]; then
  echo 'Required argument lacks.'
  exit 1
fi

git clone https://${token}@github.com/${repos}.git
cd ./tumeshogi_resolver

git fetch --all
git branch -a |
awk '{print substr($0,3)}' |
awk '$0 ~ /^remotes\/origin\/'$BRANCH_PREFIX'/ {print $0}' |
while read branch; do
 
  issue_no=${branch:23}
  [ -z $issue_no ] && continue

  state=$(getIssue | jq '.state')
  [ $state = \"closed\" ] && git push --delete origin $BRANCH_PREFIX/$issue_no

done
