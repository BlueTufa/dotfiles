{ config, pkgs, ... }:

let
  username = "badger";
in
{
  home.username = username;
  home.homeDirectory = 
    if pkgs.stdenv.isDarwin 
    then "/Users/${username}"
    else "/home/${username}";

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
    delta
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
