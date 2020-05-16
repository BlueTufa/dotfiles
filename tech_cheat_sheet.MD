# System cheat sheet
## ATOM
* copy path: ctrl-shift-c
* redo cmd-y
* toggle comments cmd-/
* move line up or down ctrl-cmd up-down
* cmd-shift-d duplicate lines!
* ctrl-t transpose
* ctrl-g go to line
* ctrl shift w select word
   
## terminal (fish specific?)
Many of these seem to work great in zsh as well.  These are similar to emacs bindings, and will often work in the OS.
* ctrl + a beginning of line
* ctrl + e end of line
* ctrl + w = delete word (backward-kill-word)
* ctrl + d = delete character under cursor 
* ctrl + arrow keys jump between words.  doesn't work on all operating systems
* ctrl + k kill to end of line
* ctrl + u kill to beginning of line
* ctrl + _ undo NOTE: use this more
* ctrl + p backwards through history 
* ctrl + n forwards through history
* ~. kill ssh session
* more here: http://web.mit.edu/gnu/doc/html/features_7.html

## Custom shortcuts
The shortcuts listed above will be enabled by default, but you can also customize your own with the bind command.  See the fish/.exports file for an example.  You use `bind --user` to establish your own.  Simply type `bind` to see the defaults or it can be used to debug problems with custom shortcuts.  It is recommended to use the custom overrides sparingly, and where practical try to override them with like commands so that you're not flailing on a foreign system.  For example, I replaced ctrl+b/f with a more agressive move command.  You can also experiment with replacing backward-kill-path-component with backward-kill-bigword if you feel that you spend a lot of time hitting ctrl-w.  I tried that but I like backward-kill-path-component more. 
* ctrl + b backward word.  Note that this key is bound to backward character by default, but backward word seems more useful to me.
* ctrl + f forward word.  This is bound to forward char by default.

## echo output to console and a file:
You can use tee to copy stdout and stderr to a file as well as the console:
`sbt liv 2>&1 | tee build.log`

## BASH / zsh AKA heredoc
Don't forget about << EOF stream redirection
```nc -v localhost 8888 << EOF
blah
EOF```

## Fish shell heredoc equivalent
You can do the same thing with fish using echo and \:
```echo "\
here" | nc -v localhost 8888```

## TAR commands
create
tar -czvf filename.tar.gz . (for hidden files)
extract
tar -xzvf test123.tar.gz
list
tar -tzvf test123.tar.gz

## OSX
show hidden files on open: cmd+shift+.
sudo nvram boot-args
  -v Verbose
  -s Single User
  -x Safe Mode
apachectl - Apache admin
launchctl - Admin interface to launchd
before you modify any config file, make a backup of it called .factory_defaults
then run sudo chmod 444 on it
enable locate service
Command + Option + ESC = Force Quit menu
full screen print Command + Shift + 3
selective screen print Command + Shift + 4
Page Down Fn + Down Arrow
Page Up Fn + Up Arrow
Beginning of Line Ctrl + A
End of Line Ctrl + E
Up one Line Ctrl + P
Down one Line Ctrl + N
Next word Alt + Right Arrow
Previous word Alt + Left Arrow
Select rest of line Shift + Down Arrow
Select to beginning of line Shift + Up Arrow
Select to beginning of document Shift + Fn + Up Arrow
Select to end of document Shift + Fn + Down Arrow
pbcopy pipe to clipboard - aliased to clip

Key system directories for MacOS:
Kernel Extensions: /System/Library/Extensions
Check for unwanted / malicious extensions
`kextstat | grep -v com.apple`
Launch agents and daeomons:
/System/Library/LaunchAgents
/System/Library/LaunchDaemons
~/Library/LaunchAgents

## linux / unix / BSD sysadmin commands
uptime
uname -a
w
whoami
hostname -I
lsof
service -—status-all
service service name restart
systemctl restart servicename
fc-list show fonts
showconsolefont

## Hack commands
airmon-ng start wlan0
Deauth
aireplay-ng -0 10 -a BSSID -c CLIENTMACID mon0
tcpdump
nmap -A -v ipaddress

## SSH shortcut keys    
    ~.: Disconnect.
    ~^Z: Background ssh.
    ~#: List forwarded connections.
    ~&: Background ssh at logout when waiting for forwarded connection / X11 sessions to terminate.
    ~?: Display a list of escape characters.
    ~B: Send a BREAK to the remote system (only useful for SSH protocol version 2 and if the peer supports it).
    ~C: Open command line. Currently this allows the addition of port forwardings using the -L, -R and -D options (see above). It also allows the cancellation of existing remote port-forwardings using -KR[bind_address:]port. !command allows the user to execute a local command if the PermitLocalCommand option is enabled in ssh_config(5). Basic help is available, using the -h option.
    ~R: Request rekeying of the connection (only useful for SSH protocol version 2 and if the peer supports it).

## JAVA
Jersey debug:
  // add the default Jackson exception mappers
  jersey.register(JsonParseExceptionMapper.class);
  jersey.register(JsonMappingExceptionMapper.class);

## SED Examples
sed 's/^: 15[0-9]\{8\}:0;//g'
remove numeric pattern starting with : 15 plus next 8 digits

## SAML / JWT / Auth
Use the following site to validate SAML tokens
https://www.samltool.com/validate_xml.php
Use the following for JWT
https://jwt.io/

## Gnome
Dealing with dconf settings, on a search for shortcut keys:
```bash
for schema in $(gsettings list-schemas); do gsettings list-recursively $schema; done | ag 'Super\>s'
```

