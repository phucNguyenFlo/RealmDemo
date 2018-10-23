#!/bin/sh

#  Script.sh
#  RealmDemo
#
#  Created by Phuc Nguyen on 10/18/18.
#  Copyright © 2018 Phuc Nguyen. All rights reserved.

hdiutil create -srcfolder "/Users/phucnguyen/Desktop/PROJECT/RealmDemo/" -volname "Realm Demo" -fs HFS+ -fsargs "-c c=64,a=16,e=16" -format UDRW -size 102400k pack.temp.dmg


device=$(hdiutil attach -readwrite -noverify -noautoopen "pack.temp.dmg" | \
egrep '^/dev/' | sed 1q | awk '{print $1}')


echo '
tell application "Finder"
tell disk "'Realm Demo'"
open
set current view of container window to icon view
set toolbar visible of container window to false
set statusbar visible of container window to false
set the bounds of container window to {400, 100, 885, 430}
set theViewOptions to the icon view options of container window
set arrangement of theViewOptions to not arranged
set icon size of theViewOptions to 72
set background picture of theViewOptions to file ".background:'backgroundPictureName.png'"
make new alias file at container window to POSIX file "/Applications" with properties {name:"Applications"}
set position of item "'Realm Demo Application'" of container window to {100, 100}
set position of item "Realm Demo Application" of container window to {375, 100}
update without registering applications
delay 5
close
end tell
end tell
' | osascript
