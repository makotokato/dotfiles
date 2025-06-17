#!/bin/sh
rsync -av --inplace --ignore-errors --delete --force --exclude ./objdir /mozilla/firefox /nas/Development/mozilla-firefox
rsync -av --inplace --ignore-errors --delete --force --exclude ./objdir /mozilla/firefox-riscv64 /nas/Development/mozilla-firefox
rsync -av --inplace --ignore-errors --delete --force --exclude ./objdir /mozilla/geckoview /nas/Development/hg.mozilla.org
rsync -av --inplace --ignore-errors --delete --force --exclude ./objdir /mozilla/gecko /nas/Development/hg.mozilla.org
rsync -av --inplace --ignore-errors --delete --force --exclude ./objdir /mozilla/geckoview-aarch64 /nas/Development/hg.mozilla.org
rsync -av --inplace --ignore-errors --delete --force --exclude ./objdir /mozilla/mozilla-unified /nas/Development/hg.mozilla.org
rsync -av --inplace --ignore-errors --delete --force --exclude ./objdir /mozilla/nss /nas/Development/hg.mozilla.org
rsync -av --inplace --ignore-errors --delete --force --exclude ./target /other/icu4x /nas/Development/github.com
