{ config, pkgs, ... }:
{
  # testing
  zramSwap.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    geary
    epiphany
    yelp
  ]);
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    git
    firefox
    libreoffice
    # Admin utilities
    btop
    gnome.gnome-tweaks
    # Gnome Extensions
    gnomeExtensions.dash-to-panel
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.arc-menu
  ];

  services.flatpak.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.operation = "boot";
  system.autoUpgrade.dates = "Mon 04:40";
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-24.05";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  #systemd.timers."auto-update-config" = {
  #wantedBy = [ "timers.target" ];
  #  timerConfig = {
  #    OnBootSec = "1m";
  #    OnCalendar = "daily";
  #    Unit = "auto-update-config.service";
  #  };
  #};

  #systemd.services."auto-update-config" = {
  #  script = ''
  #    set -eu
  #    ${pkgs.git}/bin/git -C /etc/nixbook pull
  #    ${pkgs.flatpak}/bin/flatpak update --noninteractive --assumeyes
  #  '';
  #  serviceConfig = {
  #    Type = "oneshot";
  #    User = "root";
  #  };
  #  wantedBy = [ "multi-user.target" ]; # Ensure the service starts after rebuild
  #};
}
