{ config, lib, pkgs, inputs, ... }:
let
  gruvboxPlus = import ./modules/gruvbox-plus.nix { inherit pkgs; };
in
{
  imports =
  [
    ./modules/waybar.nix
    ./modules/hyprland.nix
  ];
  home.username = "sleepy";
  home.homeDirectory = "/home/sleepy";
  # cursor
  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
  home.file = {
  ".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
  };
  # starship config
  home.file.".config/starship.toml".source = ./modules/impermanence/starship.toml;
  # rofi themes and config
  home.file.".config/rofi/config.rasi".source = ./modules/impermanence/config.rasi;
  home.file.".config/rofi/tokyonight.rasi".source = ./modules/impermanence/tokyonight.rasi;
  # wallpapers
  home.file.".config/wallpaper1.png".source = ./modules/impermanence/wallpaper_center.jpg;
  home.file.".config/wallpaper2.png".source = ./modules/impermanence/wallpaper_left.jpg;
  home.file.".config/wallpaper3.png".source = ./modules/impermanence/wallpaper_right.jpg;
  # gtk---------------------------------
  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";

  gtk.theme.package = pkgs.gruvbox-dark-gtk;
  gtk.theme.name = "gruvbox-dark";

  gtk.iconTheme.package = gruvboxPlus;
  gtk.iconTheme.name = "GruvboxPlus";
  # qt
  qt.enable = true;
  # qt.platformTheme.name = "gtk";
  qt.style.name = "adawaita-dark";
    # package to use
  qt.style.package = pkgs.adwaita-qt;
  # ------------------------------------
  # network-manager-applet
  services.network-manager-applet.enable = true;
  # blueman-applet
  services.blueman-applet.enable = true;
  # dunst
  services.dunst.enable = true;
  # ------------------------------------
  # programs
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      colors = {
        bg = "#1a1b26";
        "bg+" = "#292e42";
        fg = "#c0caf5";
        "fg+" = "#c0caf5";
        hl = "#ff9e64";
        "hl+" = "#ff9e64";
        prompt = "#7dcfff";
        pointer = "#7dcfff";
      };
    };
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
      syntaxHighlighting.enable = true;
      enableVteIntegration = true;
      autocd = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch --flake";
        f = "cd $(find * -type d | fzf)";
        fn = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' --print0 | xargs -0 -o vim";
        n = "nvim";
      };
      initExtra = ''
        if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
        fi
      '';
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
      theme = "Tokyo Night";
      shellIntegration.enableZshIntegration = true;
      settings = {
        scrollback_lines = 10000;
      };
      extraConfig = ''
        map ctrl+backspace send_text all \x17
        map ctrl+shift+h next_window
	'';
    };
    lf = {
      enable = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
  # neovim config
  programs.neovim = {
    enable = true;
    # package = pkgs.neovim-nightly;
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
  # -----------------------------
  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
    wl-clipboard
    wget
    unzip
    rustup
    usermount
    elixir_1_17
    erlang_27
    bat
    exercism
    gigalixir
    flyctl
    railway
    nodePackages_latest.node-red
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
