#! /bin/bash
plutil ./com.bluetufa.ejectbar.plist

ln -sf $(pwd)/com.bluetufa.ejectbar.plist ~/Library/LaunchAgents/com.bluetufa.ejectbar.plist
launchctl bootout gui/$(id -u)/com.bluetufa.ejectbar 2> /dev/null
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.bluetufa.ejectbar.plist
launchctl print gui/$(id -u)/com.bluetufa.ejectbar
