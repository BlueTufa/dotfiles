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

## terminal
* ctrl + w delete word backwards from command line
* ctrl + a beginning of line
* ctrl + w = delete word
* ctrl + e end of line
* alt + arrow keys jump between words. (custom)
* ctrl + k kill to end of line
* ctrl + u kill to beginning of line
* ctrl + _ undo use this more
* more here: http://web.mit.edu/gnu/doc/html/features_7.html
* ~. kill ssh session

## BASH / zsh
Don't forget about << EOF stream redirection
```nc -v localhost 8888 << EOF
blah
EOF```

You can do the same thing with fish using echo:
```echo "\
here" | nc -v localhost 8888```

## vim keys
  u = undo
  o/O insert new line below above and enter insert mode
  ctrl + b page up
  ctrl + f page down
  gg = top of document
  G = bottom of document
  b = back word
  w = next word
  e = end of word
  H = screen top
  L = screen bottom
  :vsplit filename
  ctrl + ww to switch buffers
  a = append insert mode
  0 = beginning of line
  $ = end of line
  ^ = beginning of text
  / = search
  n = next find in search mode
  N = search backwards in search mode
  3dd = cut x lines where 3 = x
  3yy = copy x lines where 3 = x
  p = paste buffer
  daw = delete a word
  yiw = yank inner word
  SHIFT + Arrow = move word
  more here: http://vim.wikia.com/wiki/All_the_right_moves
  ): Move to start of next sentence
  (: Move to start of last sentence
  }: Move to start of next paragraph (as delimited by a blank line)
  {: Move to start of last paragraph (as delimited by a blank line)
  :sp: split
  :vs: vertical split
  :%s/search/replace

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

