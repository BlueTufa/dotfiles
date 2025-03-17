for file in ~/.config/fish/.{functions*,exports*,aliases*,abbr*}
  if test -r $file
    source "$file"
  end
end

for file in ~/.config/fish/completions/*.fish
  if test -r $file
    source "$file"
  end
end

# Added by Windsurf
# fish_add_path /Users/badger/.codeium/windsurf/bin
