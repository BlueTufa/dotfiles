# Complete System Administrator's Cheat Sheet

## Text Editors

## Command Line Essentials

### Terminal Navigation (Fish, Zsh, Bash)
| Action | Shortcut |
|--------|----------|
| Beginning of line | `Ctrl+A` |
| End of line | `Ctrl+E` |
| Delete word backward | `Ctrl+W` |
| Delete character under cursor | `Ctrl+D` |
| Jump between words | `Ctrl+←/→` |
| Kill to end of line | `Ctrl+K` |
| Kill to beginning of line | `Ctrl+U` |
| Undo | `Ctrl+_` |
| Previous command in history | `Ctrl+P` |
| Next command in history | `Ctrl+N` |
| Kill SSH session | `~.` |

### Custom Shell Shortcuts
You can customize your own shortcuts with the `bind` command:

```bash
# View current bindings
bind

# Set custom user bindings
bind --user

# Example custom bindings from fish/.exports file
# Replace default backward character with backward word
bind \cb backward-word

# Replace default forward character with forward word
bind \cf forward-word
```

Use custom overrides sparingly to maintain consistency across systems.

### I/O Redirection

#### Echo Output to Console and File
```bash
# Send both stdout and stderr to file and console
sbt liv 2>&1 | tee build.log
```

#### Heredoc in Bash/Zsh
```bash
nc -v localhost 8888 << EOF
blah
EOF
```

#### Heredoc Equivalent in Fish
```bash
echo "\
here" | nc -v localhost 8888
```

### Tar Operations
```bash
# Create archive (include hidden files)
tar -czvf filename.tar.gz .

# Extract archive
tar -xzvf archive.tar.gz

# List contents
tar -tzvf archive.tar.gz
```

## macOS

### Finder & System Shortcuts
| Action | Shortcut |
|--------|----------|
| Show/hide hidden files | `Cmd+Shift+.` |
| Force Quit menu | `Cmd+Option+Esc` |
| Full screen screenshot | `Cmd+Shift+3` |
| Selective screenshot | `Cmd+Shift+4` |
| Page Down | `Fn+↓` |
| Page Up | `Fn+↑` |
| Pipe to clipboard | `command | pbcopy` |

### Text Navigation (System-wide)
| Action | Shortcut |
|--------|----------|
| Beginning of line | `Ctrl+A` |
| End of line | `Ctrl+E` |
| Up one line | `Ctrl+P` |
| Down one line | `Ctrl+N` |
| Next word | `Alt+→` |
| Previous word | `Alt+←` |
| Select rest of line | `Shift+↓` |
| Select to beginning of line | `Shift+↑` |
| Select to beginning of document | `Shift+Fn+↑` |
| Select to end of document | `Shift+Fn+↓` |

### System Administration
```bash
# Boot arguments
sudo nvram boot-args
  # -v Verbose
  # -s Single User
  # -x Safe Mode

# Apache admin
apachectl

# Launch services admin
launchctl

# Enable locate service
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# Copy to clipboard (aliased to clip)
pbcopy
```

### Key System Directories
```
# Kernel Extensions
/System/Library/Extensions

# Check for unwanted/malicious extensions
kextstat | grep -v com.apple

# Launch Agents and Daemons
/System/Library/LaunchAgents
/System/Library/LaunchDaemons
~/Library/LaunchAgents
```

## Linux/Unix/BSD Administration

### System Information
```bash
# System uptime
uptime

# Kernel version and system info
uname -a

# Current users and load
w

# Current user
whoami

# IP addresses
hostname -I

# Open files
lsof

# Service management
service --status-all
service service_name restart
systemctl restart service_name

# Font management
fc-list
showconsolefont
```

## Network & Security

### SSH Shortcut Keys
| Escape Sequence | Action |
|-----------------|--------|
| `~.` | Disconnect |
| `~^Z` | Background SSH |
| `~#` | List forwarded connections |
| `~&` | Background SSH at logout when waiting for connections |
| `~?` | Display escape character list |
| `~B` | Send BREAK to remote system |
| `~C` | Open command line |
| `~R` | Request connection rekeying |

### Network Analysis
```bash
# Wireless monitoring
airmon-ng start wlan0

# Deauthentication attack
aireplay-ng -0 10 -a BSSID -c CLIENTMACID mon0

# Packet capture
tcpdump

# Network scanning
nmap -A -v ipaddress
```

## Development

### Java
```java
// Jersey debug: add default Jackson exception mappers
jersey.register(JsonParseExceptionMapper.class);
jersey.register(JsonMappingExceptionMapper.class);
```

### SED Examples
```bash
# Remove numeric pattern starting with : 15 plus next 8 digits
sed 's/^: 15[0-9]\{8\}:0;//g'
```

### Authentication Tools
- SAML token validation: https://www.samltool.com/validate_xml.php
- JWT validation and debugging: https://jwt.io/

## Desktop Environments

### GNOME Configuration
```bash
# Search for shortcut keys in dconf settings
for schema in $(gsettings list-schemas); do gsettings list-recursively $schema; done | ag 'Super\>s'
```

## System Configuration Practices

### Best Practices
- Before modifying any config file, create a backup with `.factory_defaults` suffix
- Make backups read-only: `sudo chmod 444 filename.factory_defaults`
- Use version control for configuration files when possible
- Document system changes in a central location
