{
  description = "cybardev/nix-dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware?ref=master";

    nix-darwin = {
      url = "github:LnL7/nix-darwin?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      userName = "sage";
      darwinHost = "blade";
      linuxHost = "forest";
      nixConfigDir = "~/.config/nixos";
      genArgs =
        { host }:
        {
          inherit inputs;
          inherit nixConfigDir;
          inherit userName;
          hostName = host;
        };
      hmOpts =
        { host, config }:
        {
          backupFileExtension = "hm.bak";
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${userName} = config;
          extraSpecialArgs = genArgs { inherit host; };
        };
    in
    {
      darwinConfigurations = {
        darwin = nix-darwin.lib.darwinSystem {
          modules = [
            ./configuration-darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = hmOpts {
                host = darwinHost;
                config = ./system/home-darwin.nix;
              };
            }
          ];
          specialArgs = genArgs { host = darwinHost; };
        };
      };

      nixosConfigurations = {
        linux = nixpkgs.lib.nixosSystem {
          modules =
            [
              ./configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = hmOpts {
                  host = linuxHost;
                  config = ./system/home-linux.nix;
                };
              }
            ]
            ++ (nixpkgs.lib.optional (
              builtins.getEnv "SURFACE_KERNEL" == "1"
            ) inputs.nixos-hardware.nixosModules.microsoft-surface-common);
          specialArgs = genArgs { host = linuxHost; };
        };
      };
    };
}
