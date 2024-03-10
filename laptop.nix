
{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./configuration.nix
      inputs.home-manager.nixosModules.default
    ];
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdc";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
