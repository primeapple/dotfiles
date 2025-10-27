function mctemp --description 'Creates temporary folder and cd into it'
  cd "$(mktemp -d)"
end
