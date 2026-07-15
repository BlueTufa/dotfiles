#! /bin/bash
plutil ./com.bluetufa.ejectbar.plist
plutil ./com.bluetufa.kill-eject.plist

ln -sf $(pwd)/com.bluetufa.ejectbar.plist ~/Library/LaunchAgents/com.bluetufa.ejectbar.plist
ln -sf $(pwd)/com.bluetufa.kill-eject.plist ~/Library/LaunchAgents/com.bluetufa.kill-eject.plist
launchctl bootout gui/$(id -u)/com.bluetufa.ejectbar 2> /dev/null
launchctl bootout gui/$(id -u)/com.bluetufa.kill-eject 2> /dev/null
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.bluetufa.ejectbar.plist
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.bluetufa.kill-eject.plist
launchctl print gui/$(id -u)/com.bluetufa.ejectbar
launchctl print gui/$(id -u)/com.bluetufa.kill-eject
