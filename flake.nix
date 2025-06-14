{
  description = "cybardev/nix-dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-25.05";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin?ref=nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew?ref=main";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cypkgs = {
      url = "github:cybardev/nix-channel?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
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
          pkgs = nixpkgs.legacyPackages.${darwinConfig.system};
          modules = [
            ./pkg/darwin.nix
            { userConfig = darwinConfig; }
          ];
          extraSpecialArgs = { inherit inputs; };
        };
        "${linuxConfig.username}@${linuxConfig.hostname}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${linuxConfig.system};
          modules = [
            ./pkg/linux.nix
            { userConfig = linuxConfig; }
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };

      darwinConfigurations.${darwinConfig.hostname} = nix-darwin.lib.darwinSystem {
        modules = [
          ./sys/configuration-darwin.nix
          { userConfig = darwinConfig; }
        ];
        specialArgs = { inherit inputs; };
      };

      nixosConfigurations.${linuxConfig.hostname} = nixpkgs.lib.nixosSystem {
        modules = [
          ./sys/configuration.nix
          { userConfig = linuxConfig; }
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
