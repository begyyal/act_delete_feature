#!/bin/bash

function getIssue() {
  curl \
    -X GET \
    -H "Authorization: token $token" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/$repos/issues/$issue_no
}

token=$1
repos=$2
branch_prefix=${3:-feature}
if [ -z $token -o -z $repos ]; then
  echo 'Required argument lacks.'
  exit 1
fi

git clone https://github.com/${repos}.git
cd ./${repos#*/}

origin=${GITHUB_SERVER_URL:-${GITHUB_URL:-https://github.com}}
token64=$(printf "%s""x-access-token:$token" | base64)
git config --local http.${origin}/.extraheader "AUTHORIZATION: basic $token64"

git fetch --all
git branch -a |
awk '{print substr($0,3)}' |
awk '$0 ~ /^remotes\/origin\/'$branch_prefix'/ {print $0}' |
while read branch; do
 
  issue_no=${branch:23}
  [ -z $issue_no ] && continue

  state=$(getIssue | jq '.state')
  [ $state = \"closed\" ] && git push --delete origin $branch_prefix/$issue_no

done

exit 0
