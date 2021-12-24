for file in ~/.config/fish/.{functions*,exports*,aliases*}
  if test -r $file
    source "$file"
  end
end


# test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

