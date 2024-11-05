#!/usr/bin/env bash

###############################################################################
# NSGlobalDomain                                                              #
###############################################################################

# Set highlight and accent colors orange
defaults write NSGlobalDomain AppleHighlightColor -string "1.000000 0.874510 0.701961 Orange"
defaults write NSGlobalDomain AppleAccentColor -int 1

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# time formats
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
defaults write com.apple.menuextra.clock ShowSeconds -bool true

###############################################################################
# control center                                                              #
###############################################################################
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Energy saving                                                               #
###############################################################################

# Never go into computer sleep or low power mode when on AC power
sudo pmset -c sleep 0
sudo pmset -a lowpowermode 0

# Hibernation mode
# 0: Disable hibernation (speeds up entering sleep mode)
# 3: Copy RAM to disk so the system state can still be restored in case of a
#    power failure.
# sudo pmset -a hibernatemode 0

###############################################################################
# Finder                                                                      #
###############################################################################

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool false

# Finder: show tool bar
defaults write com.apple.finder ShowToolbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
# defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
# defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
# chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
# sudo chflags nohidden /Volumes


# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
# defaults write com.apple.finder FXInfoPanesExpanded -dict \
# 	General -bool true \
# 	OpenWith -bool true \
# 	Privileges -bool true

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Enable highlight hover effect for the grid view of a stack (Dock)
# defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to x pixels
defaults write com.apple.dock tilesize -int 72
defaults write com.apple.dock largesize -int 96

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
#defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
#defaults write com.apple.dock static-only -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Magnification
defaults write com.apple.dock magnification -bool true

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner
# defaults write com.apple.dock wvous-tl-corner -int 0
# defaults write com.apple.dock wvous-tl-modifier -int 0

# # Top right screen corner
# defaults write com.apple.dock wvous-tr-corner -int 0
# defaults write com.apple.dock wvous-tr-modifier -int 0

# # Bottom left screen corner
# defaults write com.apple.dock wvous-bl-corner -int 1
# defaults write com.apple.dock wvous-bl-modifier -int 0

# Disable bottom right hot corner
defaults write com.apple.dock wvous-br-corner -int 1
# defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Time Machine                                                                #
###############################################################################

# Disable local Time Machine backups
# hash tmutil &> /dev/null && sudo tmutil disablelocal


# Disable the Launchpad gesture (pinch with thumb and three fingers)
#defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Reset Launchpad, but keep the desktop wallpaper intact
# find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Add iOS & Watch Simulator to Launchpad
# sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
# sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"

# Add a spacer to the left side of the Dock (where the applications are)
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the right side of the Dock (where the Trash is)
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
# defaults write com.apple.Safari UniversalSearchEnabled -bool false
# defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
# defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
# defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
# defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
# defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
# defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
# defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
# defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
# defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
# defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
# defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
# defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
# defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
# defaults write com.apple.Safari AutoFillFromAddressBook -bool false
# defaults write com.apple.Safari AutoFillPasswords -bool false
# defaults write com.apple.Safari AutoFillCreditCardData -bool false
# defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Warn about fraudulent websites
# defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Disable plug-ins
# defaults write com.apple.Safari WebKitPluginsEnabled -bool false
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Disable Java
# defaults write com.apple.Safari WebKitJavaEnabled -bool false
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

# Block pop-up windows
# defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Disable auto-playing video
#defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
#defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
#defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

# Enable “Do Not Track”
# defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
# defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

###############################################################################
# Mail                                                                        #
###############################################################################

# Disable send and reply animations in Mail.app
# defaults write com.apple.mail DisableReplyAnimations -bool true
# defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
# defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
# defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

# Display emails in threaded mode, sorted by date (oldest at the top)
# defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
# defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
# defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# Disable inline attachments (just show the icons)
# defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Disable automatic spell checking
# defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
# sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
# 	MENU_DEFINITION
# 	MENU_CONVERSION
# 	MENU_EXPRESSION
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
# defaults write com.apple.spotlight orderedItems -array \
# 	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
# 	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
# 	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
# 	'{"enabled" = 1;"name" = "PDF";}' \
# 	'{"enabled" = 1;"name" = "FONTS";}' \
# 	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
# 	'{"enabled" = 0;"name" = "MESSAGES";}' \
# 	'{"enabled" = 0;"name" = "CONTACT";}' \
# 	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
# 	'{"enabled" = 0;"name" = "IMAGES";}' \
# 	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
# 	'{"enabled" = 0;"name" = "MUSIC";}' \
# 	'{"enabled" = 0;"name" = "MOVIES";}' \
# 	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
# 	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
# 	'{"enabled" = 0;"name" = "SOURCE";}' \
# 	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
# 	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
# 	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
# 	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
# 	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
# 	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Load new settings before rebuilding the index
# killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
# sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
# sudo mdutil -E / > /dev/null

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
# defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Solarized Dark theme by default in Terminal.app
# osascript <<EOD

# tell application "Terminal"

# 	local allOpenedWindows
# 	local initialOpenedWindows
# 	local windowID
# 	set themeName to "Solarized Dark xterm-256color"

# 	(* Store the IDs of all the open terminal windows. *)
# 	set initialOpenedWindows to id of every window

# 	(* Open the custom theme so that it gets added to the list
# 	   of available terminal themes (note: this will open two
# 	   additional terminal windows). *)
# 	do shell script "open '$HOME/init/" & themeName & ".terminal'"

# 	(* Wait a little bit to ensure that the custom theme is added. *)
# 	delay 1

# 	(* Set the custom theme as the default terminal theme. *)
# 	set default settings to settings set themeName

# 	(* Get the IDs of all the currently opened terminal windows. *)
# 	set allOpenedWindows to id of every window

# 	repeat with windowID in allOpenedWindows

# 		(* Close the additional windows that were opened in order
# 		   to add the custom theme to the list of terminal themes. *)
# 		if initialOpenedWindows does not contain windowID then
# 			close (every window whose id is windowID)

# 		(* Change the theme for the initial opened terminal windows
# 		   to remove the need to close them in order for the custom
# 		   theme to be applied. *)
# 		else
# 			set current settings of tabs of (every window whose id is windowID) to settings set themeName
# 		end if

# 	end repeat

# end tell

# EOD

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
# defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
# defaults write com.apple.Terminal ShowLineMarks -int 0

# Install the Solarized Dark theme for iTerm
# open "${HOME}/init/Solarized Dark.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
# defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
# defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
# defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
# defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
# defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

# Enable the debug menu in Address Book
# defaults write com.apple.addressbook ABShowDebugMenu -bool true

# Enable Dashboard dev mode (allows keeping widgets on the desktop)
# defaults write com.apple.dashboard devmode -bool true

# Enable the debug menu in iCal (pre-10.8)
# defaults write com.apple.iCal IncludeDebugMenu -bool true

# Use plain text mode for new TextEdit documents
# defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
# defaults write com.apple.TextEdit PlainTextEncoding -int 4
# defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Enable the debug menu in Disk Utility
# defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
# defaults write com.apple.DiskUtility advanced-image-options -bool true

# Auto-play videos when opened with QuickTime Player
# defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the WebKit Developer Tools in the Mac App Store
# defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
# defaults write com.apple.appstore ShowDebugMenu -bool true

# Enable the automatic update check
# defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
# defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
# defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
# defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs
# defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn on app auto-update
# defaults write com.apple.commerce AutoUpdate -bool true

# Allow the App Store to reboot machine on macOS updates
# defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

###############################################################################
# Messages                                                                    #
###############################################################################

# Disable automatic emoji substitution (i.e. use plain text smileys)
# defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes as it’s annoying for messages that contain code
# defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
# defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

# Disable the all too sensitive backswipe on trackpads
# defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
# defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

# Disable the all too sensitive backswipe on Magic Mouse
# defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
# defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

# Use the system-native print preview dialog
# defaults write com.google.Chrome DisablePrintPreview -bool true
# defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# Expand the print dialog by default
# defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
# defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

