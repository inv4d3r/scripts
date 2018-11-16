#!/bin/bash

tag=$(git describe --tags --abbrev=0)
branch=$(git rev-parse --abbrev-ref HEAD)
reqfile=./"$branch"-pull-request
remoteurl=$(git config --get remote.origin.url)

echo "remote url is "$remoteurl""
echo "last tag is "$tag", branch is "$branch""

if [ -f $reqfile ]; then
  if [ -f $reqfile.bak ]; then
    i=0
    while :
    do
      if [ ! -f $reqfile.bak.$i ]; then
	cp $reqfile $reqfile.bak.$i
	echo "previous request pull successfully backed up as " $reqfile.bak.$i
	break
      fi
      let i=$i+1
    done
  else
    cp $reqfile $reqfile.bak
    echo "previous request pull successfully backed up as " $reqfile.bak
  fi
fi

echo "preparing pull request header"
header=$(branch=$branch tag=$tag envsubst < ./intel-next-pull-header)

echo "saving pull request to "$reqfile""
echo "$header" > "$reqfile"
echo >> "$reqfile"
git request-pull refs/tags/"$tag" "$remoteurl" "$branch" >> "$reqfile"

