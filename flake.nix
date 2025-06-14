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
      userConfig = {
        nickname = "Sheikh";
        username = "sage";
        locale = "en_CA.UTF-8";
        timezone = "America/Halifax";
        configDir = "~/.config/nixos";
        hostname = "forest";
        system = "x86_64-linux";
      };
      userConfigDarwin = userConfig // {
        isDarwin = true;
        hostname = "blade";
        system = "aarch64-darwin";
      };
    in
    {
      homeConfigurations = {
        "${userConfig.username}@${userConfigDarwin.hostname}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${userConfigDarwin.system};
          modules = [
            ./pkg/darwin.nix
            { userConfig = userConfigDarwin; }
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
        "${userConfig.username}@${userConfig.hostname}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${userConfig.system};
          modules = [
            ./pkg/linux.nix
            { inherit userConfig; }
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };

      darwinConfigurations.${userConfigDarwin.hostname} = nix-darwin.lib.darwinSystem {
        modules = [
          ./sys/configuration-darwin.nix
          { userConfig = userConfigDarwin; }
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      nixosConfigurations.${userConfig.hostname} = nixpkgs.lib.nixosSystem {
        modules = [
          ./sys/configuration.nix
          { inherit userConfig; }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
}
