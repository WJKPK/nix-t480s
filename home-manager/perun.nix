{pkgs, ...}: {
  imports = [
    ./common.nix
    ./nixos-specific.nix
    ./wallpapers
    ./programs/neovim
    ./programs/kitty
    ./programs/zsh
    ./programs/git
    ./programs/direnv
    ./programs/rofi
    ./programs/kicad
    ./programs/tmux-sessionizer
    ./programs/yazi
    ./programs/btop
    ./programs/openscad
    ./programs/dunst
    ./programs/hypr
    ./programs/waybar
    ./programs/hyprlock
    ./programs/hyprshade
  ];
  monitors = [
    {
      name = "DP-1";
      width = 3440;
      height = 1440;
      x = 0;
      workspace = "1";
      scale = 1.0;
      refreshRate = 165; 
      enabled = true;
      primary = true;
    }
  ];
  home = {
    username = "kruppenfield";
    homeDirectory = "/home/kruppenfield";
  };

  programs.git = {
    enable = true;
    userEmail = "krupskiwojciech@gmail.com";
    userName = "WJKPK";
  };
  desktop.addons.waybar.enable = true;
  home.packages = with pkgs; [
    nvtopPackages.full
    arc-theme
    stm32cubemx
    saleae-logic-2
    xfce.thunar
    xfce.xfce4-appfinder
    xfce.xfce4-settings
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.ristretto
    xfce.tumbler
    logseq
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

