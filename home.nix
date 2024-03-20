{ config, lib, pkgs, inputs, ... }:
{
  imports =
  [
    # ./modules/waybar.nix
    ./modules/hyprland.nix
  ];
  home.username = "sleepy";
  home.homeDirectory = "/home/sleepy";
  # cursor
  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
  # wallpapers
  home.file.".config/starship.toml".source = ./modules/impermanence/starship.toml;
  home.file.".config/wallpaper1.png".source = ./modules/impermanence/gruvbox-dark-rainbow.png;
  home.file.".config/wallpaper2.png".source = ./modules/impermanence/gruvbox_pixel.png;
  home.file.".config/wallpaper3.png".source = ./modules/impermanence/gruv-simplistic-ngo.png;
  # gtk
  gtk.enable = true;
  # qt
  qt.enable = true;
  # network-manager-applet
  services.network-manager-applet.enable = true;
  # blueman-applet
  services.blueman-applet.enable = true;
  # dunst
  services.dunst.enable = true;
  # programs
  programs = {
    lazygit = {
        enable = true;
      };
    gh = {
      enable = true;
      settings.git_protocol = "https";
      gitCredentialHelper.enable = true;
      gitCredentialHelper.hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
    git = {
      enable = true;
      userName  = "notsooSleepy";
      userEmail = "bartlomiej.grabarek1@gmail.com";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      # enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      enableVteIntegration = true;
      autocd = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
        f = "fzf";
        n = "nvim";
      };
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "robbyrussell";
      };
    };
    kitty = {
      enable = true;
      font.package = pkgs.fira-code;
      font.name = "FiraCode";
      font.size = 12;
      theme = "Gruvbox Material Dark Hard";
      settings = {
        scrollback_lines = 10000;
      };
      extraConfig = ''
        map ctrl+backspace send_text all \x17
        map ctrl+shift+h next_window
	'';
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
  # neovim config
  nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      telescope-fzf-native-nvim
    ];
    extraConfig = ''
      set tabstop=2
      set shiftwidth=2
      set expandtab     
      set smarttab
      set number
      colorscheme gruvbox
    '';
  };
  home.file."./.config/nvim/" = {
    source = ./modules/nvim;
    recursive = true;
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
    wl-clipboard
    wget
    unzip
    rustup
    usermount
  ];
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  programs.home-manager.enable = true;

  }
