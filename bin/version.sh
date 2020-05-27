#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

TAG=`git describe --abbrev=0 --tags`
DESCRIBE=`git describe --tags`
HASH=`git rev-parse HEAD`
if [ "$(uname)" == "Darwin" ]; then
        GITDATE=`git show -s --format=%ct HEAD`
        DATE=`date -r "$GITDATE" -u +"%Y%m%d"`
else
	GITDATE=`git show -s --format=%ci HEAD`
	DATE=`date --date="$GITDATE" -u +"%Y%m%d"`
fi

if [ "$TAG" == "$DESCRIBE" ]; then
	VERSION="$TAG"
else
	VERSION="$TAG-$DATE.${HASH:0:7}"
fi

echo $VERSION
echo -n $VERSION > $DIR/../VERSION
