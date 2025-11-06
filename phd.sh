phdta () {
  local version=$1

  if test -z $version; then
    echo 'Version is required'
    return
  fi

  ssh zeio@dark mkdir -p \$HOME/aura/assets/data/$version/raw

  for file in $HOME/Documents/PhD/$version/*.docx; do
    scp $file zeio@dark:/home/zeio/aura/assets/data/$version/raw
  done
}
