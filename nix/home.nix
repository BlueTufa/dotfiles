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
    btop
    curl
    delta
    doggo
    duf
    dust
    eza
    fastfetch
    fclones
    fd
    fzf
    gh
    git
    git-lfs
    httpie
    iperf3
    jq
    mtr
    neovim
    nmap
    procs
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
