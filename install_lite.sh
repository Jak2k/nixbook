echo "This will delete ALL local files and convert this machine to a Nixbook Lite!";
read -p "Do you want to continue? (y/n): " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
  echo "Installing NixBook Lite..."

  # Set up local files
  rm -rf ~/
  mkdir ~/Desktop
  mkdir ~/Documents
  mkdir ~/Downloads
  mkdir ~/Pictures
  cp -R /etc/nixbook/config/config_lite ~/.config
  cp /etc/nixbook/config/desktop_lite/* ~/Desktop/

  # Add Nixbook config and rebuild
  sudo sed -i '/hardware-configuration\.nix/a\      /etc/nixbook/base_lite.nix' /etc/nixos/configuration.nix
  sudo nixos-rebuild switch
  
  reboot
else
  echo "Nixbook Lite Install Cancelled!"
fi

