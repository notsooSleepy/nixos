# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports = [
      inputs.home-manager.nixosModules.default
    ];
  # flake setup
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # for lua-language-server
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    lua-language-server
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Warsaw";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };
  # Configure console keymap
  console.keyMap = "pl2";
  # display manager
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "hyprland";
  #shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  # hyprland
  security.polkit.enable = true;
  programs.hyprland = { 
  enable = true;
  xwayland.enable = true;
  package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
  # thunar
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  # audio
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;
  # unfree packages
  nixpkgs.config.allowUnfree = true;
  # fonts
  fonts.packages = with pkgs; [
  nerdfonts
  fira-code
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sleepy = {
    isNormalUser = true;
    description = "sleepy";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    git
    gh
    google-chrome
    kitty
    warp-terminal
    rofi-wayland
    pavucontrol
    lf
    du-dust
    fzf
    btop
    thefuck
    grimblast
    obsidian
    qbittorrent
    swww
    fira-code
    mpv-unwrapped
    ani-cli
    lua-language-server
    lxappearance
    ];
  }; 
  # home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "sleepy" = import ./home.nix;
    };
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
