#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=./teeworlds.png
export DESKTOP=./teeworlds.desktop
export DEPLOY_OPENGL=1
export DEPLOY_DATADIR=0

# Deploy dependencies
quick-sharun /usr/bin/teeworlds /usr/bin/teeworlds_srv

# Teeworlds looks for its data directory next to the path it was started as,
# so $APPDIR/bin/data is where it has to be for the game to find its
# resources (it then reports it as $DATADIR)
cp -rv /usr/share/teeworlds/data ./AppDir/bin/

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage