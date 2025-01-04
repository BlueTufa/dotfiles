for file in ~/.config/fish/.{functions*,exports*,aliases*}
  if test -r $file
    source "$file"
  end
end

for file in ~/.config/fish/completions/*.fish
  if test -r $file
    source "$file"
  end
end
