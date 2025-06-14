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
        darwinHost = "blade";
        linuxHost = "forest";
        darwinSystem = "aarch64-darwin";
        linuxSystem = "x86_64-linux";
        locale = "en_CA.UTF-8";
        timezone = "America/Halifax";
        nixos = "~/.config/nixos";
      };
      genArgs =
        {
          home,
          host,
          system,
        }:
        {
          inherit inputs;
          inherit userConfig;
          hostName = host;
          flakePath = "${home}${builtins.substring 1 (-1) userConfig.nixos}";
          extraArgs = {
            inherit home;
            inherit system;
          };
        };
      darwinArgs = genArgs {
        host = userConfig.darwinHost;
        home = "/Users/${userConfig.username}";
        system = userConfig.darwinSystem;
      };
      linuxArgs = genArgs {
        host = userConfig.linuxHost;
        home = "/home/${userConfig.username}";
        system = userConfig.linuxSystem;
      };
    in
    {
      homeConfigurations = {
        "${userConfig.username}@${userConfig.darwinHost}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${darwinArgs.extraArgs.system};
          modules = [ ./pkg/darwin.nix ];
          extraSpecialArgs = darwinArgs;
        };
        "${userConfig.username}@${userConfig.linuxHost}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${linuxArgs.extraArgs.system};
          modules = [ ./pkg/linux.nix ];
          extraSpecialArgs = linuxArgs;
        };
      };

      darwinConfigurations.${userConfig.darwinHost} = nix-darwin.lib.darwinSystem {
        modules = [ ./sys/configuration-darwin.nix ];
        specialArgs = darwinArgs;
      };

      nixosConfigurations.${userConfig.linuxHost} = nixpkgs.lib.nixosSystem {
        modules = [ ./sys/configuration.nix ];
        specialArgs = linuxArgs;
      };
    };
}
