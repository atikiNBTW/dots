#!/bin/bash

# Function to prompt and create symlinks
create_symlink() {
  local name=$1        # Display name for the dotfiles
  local source_path=$2 # Source file or directory
  local target_path=$3 # Target location

  # Prompt user
  echo -n "Install $name dots? [Y/n] "
  read response
  response=${response:-Y}                       # Default to "Y" if empty
  response=$(echo "$response" | tr 'a-z' 'A-Z') # Convert to uppercase

  # Check response and create symlink if 'Y'
  if [[ "$response" == "Y" ]]; then
    if [[ -e $target_path ]]; then
      echo "$target_path already exists. Skipping..."
    else
      ln -s "$source_path" "$target_path"
      echo "$name dots installed."
    fi
  fi
}

# Define dotfiles to install
create_symlink "alacritty" "./alacritty" "$HOME/.config/alacritty"
create_symlink "hyprland" "./hypr" "$HOME/.config/hypr"
create_symlink "tmux" "./tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
create_symlink "waybar" "./waybar" "$HOME/.config/waybar"
create_symlink "wofi" "./wofi" "$HOME/.config/wofi"

# Special case: zapret dots
echo -n "Install zapret dots? [Y/n] "
read response
response=${response:-Y}
response=$(echo "$response" | tr 'a-z' 'A-Z')
if [[ "$response" == "Y" ]]; then
  echo "Please install zapret manually and then copy it yourself."
fi

# More dotfiles
create_symlink "zsh" "./.zshrc" "$HOME/.zshrc"
create_symlink "zsh theme (powerlevel10k)" "./.p10k.zsh" "$HOME/.p10k.zsh"
create_symlink "cursors" "./.icons/" "$HOME/.icons"

echo "All selected dotfiles have been processed."
