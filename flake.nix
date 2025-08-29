{
  description = "cybardev/nix-dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs?ref=nixpkgs-25.05-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin?ref=nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew?ref=main";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    opencode-tap = {
      url = "github:sst/homebrew-tap";
      flake = false;
    };

    cypkgs = {
      url = "github:cybardev/nix-channel?ref=main";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    secrets = {
      url = "git+ssh://git@localhost:222/cybardev/.secrets.git?shallow=1";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }@inputs:
    let
      nixpkgs-unstable =
        system:
        import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfreePredicate = import ./sys/unfree.nix { inherit (inputs.nixpkgs-unstable) lib; };
          overlays = import ./sys/overlays.nix { inherit inputs; };
        };
      nixpkgs-darwin =
        system:
        import inputs.nixpkgs-darwin {
          inherit system;
          config.allowUnfreePredicate = import ./sys/unfree.nix { inherit (inputs.nixpkgs-unstable) lib; };
          overlays = import ./sys/overlays.nix { inherit inputs; };
        };
      linuxConfig = {
        username = "sage";
        hostname = "forest";
        system = "x86_64-linux";
      };
      darwinConfig = linuxConfig // {
        hostname = "blade";
        system = "aarch64-darwin";
      };
    in
    {
      homeConfigurations = {
        "${darwinConfig.username}@${darwinConfig.hostname}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs-darwin darwinConfig.system;
          modules = [
            ./pkg/darwin.nix
            { userConfig = darwinConfig; }
          ];
          extraSpecialArgs = {
            inherit inputs;
            pkgs-unstable = nixpkgs-unstable darwinConfig.system;
          };
        };
        "${linuxConfig.username}@${linuxConfig.hostname}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${linuxConfig.system};
          modules = [
            ./pkg/linux.nix
            { userConfig = linuxConfig; }
          ];
          extraSpecialArgs = {
            inherit inputs;
            pkgs-unstable = nixpkgs-unstable linuxConfig.system;
          };
        };
      };

      darwinConfigurations.${darwinConfig.hostname} = nix-darwin.lib.darwinSystem {
        modules = [
          ./sys/configuration-darwin.nix
          { userConfig = darwinConfig; }
        ];
        specialArgs = {
          inherit inputs;
          pkgs-unstable = nixpkgs-unstable darwinConfig.system;
        };
      };

      nixosConfigurations.${linuxConfig.hostname} = nixpkgs.lib.nixosSystem {
        modules = [
          ./sys/configuration.nix
          { userConfig = linuxConfig; }
        ];
        specialArgs = {
          inherit inputs;
          pkgs-unstable = nixpkgs-unstable linuxConfig.system;
        };
      };
    };
}
