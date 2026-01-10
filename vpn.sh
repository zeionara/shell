#!/bin/bash

mihomo_root="$HOME/.config/mihomo"
log="$mihomo_root/log.txt"

alias mihomou='$ZSH_CUSTOM/bashrc/vpn/vpn29/update-config.sh'

mup () {
  if (( $(ps -aux | grep mihomo | grep -v 'vim\|grep' | wc -l) < 1 )); then
    echo >> "$log"
    echo $(date +"%Y-%m-%d %H:%M:%S") Starting mihomo >> "$log"
    echo >> "$log"
    nohup mihomo >> "$log" 2>&1 &
  else
    echo mihomo is already running
  fi
}

mdn () {
  if (( $(ps -aux | grep mihomo | grep -v 'grep' | wc -l) < 1 )); then
    echo mihomo is not running yet
  else
    ps -aux | grep mihomo | grep -v 'vim\|grep' | head -n 1 | awk '{print $2}' | xargs kill
    echo >> "$log"
    echo $(date +"%Y-%m-%d %H:%M:%S") Stopped mihomo >> "$log"
    echo >> "$log"
  fi
}

mst () {
  if (( $(ps -aux | grep mihomo | grep -v 'vim\|grep' | wc -l) < 1 )); then
    echo mihomo is not running
  else
    echo mihomo is running
  fi
}

mupd () {
  mihomo_root=$HOME/.config/mihomo

  config="$mihomo_root/config.yaml"
  config_backup_dir="$mihomo_root/backups"
  config_backup="$config_backup_dir/config.yaml"

  if [[ ! -d "$config_backup_dir" ]]; then
    mkdir $config_backup_dir
  fi

  if [[ -f "$config" ]]; then
    cp $config "$config_backup.$(date +%Y.%m.%dT%H.%M.%S)"
  fi

  wget -q "$MIHOMO_CONFIG_URL" -O "$config"
}
