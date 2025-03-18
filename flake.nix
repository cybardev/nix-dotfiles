{
  description = "cybardev/nix-dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cypkgs = {
      url = "github:cybardev/nix-channel/main";
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
    {
      darwinConfigurations = {
        blade = nix-darwin.lib.darwinSystem {
          modules = [
            ./configuration-darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                backupFileExtension = "hm.bak";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.sage = ./system/home-darwin.nix;
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };

      nixosConfigurations = {
        linux = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                backupFileExtension = "hm.bak";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.sage = ./system/home-linux.nix;
                extraSpecialArgs = { inherit inputs; };
              };
            }
            # inputs.nixos-hardware.nixosModules.microsoft-surface-common
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
