#!/usr/bin/env bash

curl -s https://raw.githubusercontent.com/BigWigsMods/packager/master/release.sh | bash -s -- -g 8.2.5
curl -s https://raw.githubusercontent.com/BigWigsMods/packager/master/release.sh | bash -s -- -g 1.13.2

curlfiles=""
for file in "/home/travis/build/iMintty/TRP3-Location-Toggle/.release"/*
do
    if [ ${file: -4} == ".zip" ]
    then
        curlfiles="$curlfiles -F '$(basename $file)=@$file'"
    fi
done

curl $curlfiles $DISCORD_WEBHOOK
echo $curlfiles