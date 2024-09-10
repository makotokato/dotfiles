#!/bin/sh
rsync -av --inplace --ignore-errors --delete --force –progress /mozilla/geckoview /nas/Development/hg.mozilla.org

