#!/usr/bin/env bash

git checkout master
git tag -fam "v$1" $1
git push origin master && git push --tags