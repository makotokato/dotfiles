#!/bin/sh
PATH="$PATH:/home/makoto/bin/depot_tools"
cd /other/chromium/src
git pull
git checkout origin/main
gclient sync -D
