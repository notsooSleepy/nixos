{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ nixpkgs, hyprland, zen-browser, hyprland-qtutils, home-manager,... }: {
      nixosConfigurations.desktop_1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs; };
        modules = [ 
          ./desktop_1.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      nixosConfigurations.desktop_2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs; };
        modules = [ 
          ./desktop_2.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs; };
        modules = [ 
          ./laptop.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
