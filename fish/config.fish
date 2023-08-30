for file in ~/.config/fish/.{functions*,exports*,aliases*}
  if test -r $file
    source "$file"
  end
end
