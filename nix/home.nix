{ config, pkgs, ... }:
{
  let
  username = builtins.getEnv "USER";
  home.username = "${username}";
  home.homeDirectory = "/Users/YOUR_USERNAME";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bat
    curl
    eza
    fclones
    fd
    fzf
    gh
    git
    git-delta
    git-lfs
    jq
    neovim
    nmap
    pwgen
    ripgrep
    rsync
    socat
    tree
    watch
    wget
    yq
    zoxide
  ];

  programs.git.enable = true;

  programs.zoxide.enable = true;

  programs.starship.enable = true;

  programs.fzf.enable = true;

  programs.bat.enable = true;

  programs.eza.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.home-manager.enable = true;
}