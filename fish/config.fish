for file in ~/.config/fish/.{functions*,exports*,aliases*}
  echo "Sourcing $file..."
  if test -r $file
    source "$file"
  end
end

