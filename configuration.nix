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
  # cachix for hyprland
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
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
  # blueman for wifi
  services.blueman.enable = true;
  # audio
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };
  # Virtualisation
  programs.dconf.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  #shell
  # programs.zsh.enable = true;
  # users.defaultUserShell = pkgs.zsh;
  # hyprland
  security.polkit.enable = true;
  security.pam.services.swaylock = {};
  programs.hyprland = { 
  enable = true;
  xwayland.enable = true;
  };
  # ------------------------------------
  # display manager
  services = {
    xserver.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        theme = "catppuccin-sddm-corners";
        # theme = "${import ./modules/sddm-theme.nix { inherit pkgs; }}";
        wayland.enable = true;
      };
    };
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
  # flatpack
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  # ------------------------------------
  # docker
  virtualisation.docker.enable = true;
  # for lua-language-server
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    lua-language-server
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  # wacom tablet
  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  # steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};
  # fonts
  fonts.packages = with pkgs; [
  fira-code
  ]++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sleepy = {
    isNormalUser = true;
    description = "sleepy";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd"];
    packages = with pkgs; [
  # ------------------------------------
    gcc
    gnumake
    efibootmgr
  # ---------------
    pavucontrol
    wireplumber
  # ---------------
    wlogout
    swayidle
    swaylock
  # ---------------
    networkmanagerapplet
    libappindicator-gtk3
    inotify-tools
    libnotify
    glib
  # ---------------
    fira-code
  # ------------------------------------
    git
    gh
    lf
    du-dust
    btop
    thefuck
    grimblast
    ripgrep
    bat
    fd
    wl-clipboard
    wget
    zip
    xz
    unzip
    p7zip
    usermount
    reptyr
  # ------------------------------------
    google-chrome
    vivaldi
    kitty
    qbittorrent
    mate.atril
    barrier # KVM software
  # ------------------------------------
    rofi-wayland
    swww
    feh
  # ------------------------------------
    rustup
    cargo
  # ---------------
    python3
    python313Full
    python312Packages.pytest
    python312Packages.pip
    poetry
  # ---------------
    elixir_1_17
    erlang_27
  # ---------------
    nodejs_22
    nodePackages_latest.node-red
  # ---------------
    lua
    lua-language-server
    luajitPackages.luarocks
    tree-sitter
  # ---------------
    go
  # ---------------
    htmx-lsp
  # ------------------------------------
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
    libsForQt5.qt5.qtgraphicaleffects
    catppuccin-sddm-corners
    catppuccin
  # Virtualisation packages------------------------------------
    virt-manager
    virt-viewer
    spice 
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    adwaita-icon-theme
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
