# Themes folder
This folder contains themes config files, either for iTerm2, IntelliJ, or other tools that accept configuration imports/exports.
Due to the inconsistency of each tool's import/export features, there are no plans to try to automate this or symlink it at this time.

## Gruvbox themes
The gruvbox files here are exports from iTerm2 and IntelliJ that imitate the gruvbox theme.  Note that there is also an environment variable defined for FISH_THEME that you should set to gruvbox if you want it to automatically pick up the gruvbox colors for the command prompt.

For IntelliJ, you must install the Material Theme UI plug-in from the marketplace and then import the gruvbox.xml file into the Material Theme configuration as "Custom Theme".  You must then separately import the gruvbox.icls file under Editor->Color Scheme->General.  This might sound like a lot of trouble but it's really not.  Expect to have some color inconsistency, especially around feature dialogs and alternate languages.  I spent probably 20 minutes actually defining the colors, optimizing it for Scala.  I then proceeded to spend more time than that getting it into version control and writing documentation.  

For the gruvbox themed iTerm color scheme, Simply import gruvbox.json into iTerm2 as a profile under Preferences -> Profiles -> Other Actions -> Import Json Profiles.

## Solarized themes
These are the color schemes that I have been running for a long time and are easy on the eyes.  It's based roughly on the default solarized theme from iTerm2, and the default Fish shell theme matches it.  Simply import Solarized.json into iTerm2 as a profile under Preferences -> Profiles -> Other Actions -> Import Json Profiles.

* Again, I probably spent more time on documentation than I did the actual colors, so if you feel that you make improvements to what I started, please don't hesitate to open a PR against these theme files!
