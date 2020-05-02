# bin
This directory is for scripts that you intend to treat as executables.  ~/src/bin is added to the path in my dotfiles, allowing for access from anywhere in the CLI. 

The path ~/src/bin is automatically created and added to the path, but none of these files are copied there by default.  You are on your own to choose which of these are useful, if any, and copy them to ~/src/bin manually.

Remember to mark them executable and use a portable shebang such as `#! /usr/bin/env bash` and you don't need to use the file extension. For example, rename `backup.sh` to `backup` and then you can simply type `backup` from anywhere. 

### Backup with rsync
Includes a simple script that will backup to an encrypted external drive using rsync.  You may need to modify it depending on your hardware configuration and operating system.

### Example script for mounting an encrypted Luks volume
Again, this may vary based on your hardware and operating system configuration.

### flash-1up
Flashes a 1up keyboard with locally compiled firmware.  See https://github.com/BlueTufa/qmk_firmware for more details.

### bash for loop starter
Skeleton script for a very common task, which is to create a script that executes some command and iterates over the results in the shell.  

### bash mass update starter
Skeleton script for finding all occurrences of a regex and replacing it with a different value, recursively.  Requires `the_silver_searcher` aka `ag` to be installed as a prerequisite.  Or you can change it to use `grep`.

### AWS
Various AWS and/or ELK helpers that change based on seasonality and my mood.

