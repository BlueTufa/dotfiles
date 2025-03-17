# In your IPython configuration file (usually located at ~/.ipython/profile_default/ipython_config.py)
c = get_config()

# Change the color scheme
c.TerminalInteractiveShell.colors = 'Linux'  # Options: 'NoColor', 'Linux', 'LightBG', 'Neutral'

# Or for syntax highlighting
c.TerminalInteractiveShell.highlighting_style = 'solarized-dark'

c.TerminalInteractiveShell.history_length = 100000

# Startup commands
c.InteractiveShellApp.exec_lines = [
    'import os'
]


c.AliasManager.user_aliases = [
    ('ll', 'eza -aa -g --long --header --git'),
    ('cat', 'bat --theme=ansi'),
    ('vi', 'nvim')
]
