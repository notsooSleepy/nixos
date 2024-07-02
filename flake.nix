{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        homeConfigurations."sleepy@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./desktop.nix
            inputs.home-manager.nixosModules.default
            hyprland.homeManagerModules.default {
              wayland.windowManager.hyprland.enable = true;
            }
          ];
          specialArgs = {inherit inputs; };
      };
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs; };
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ 
          ./laptop.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
