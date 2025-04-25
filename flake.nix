{
  description = "cybardev/nix-dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

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

  outputs = {
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  } @ inputs: let
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
    genArgs = {
      home,
      host,
      system,
    }: {
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
    hmConfig = {
      configs,
      args,
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${args.extraArgs.system};
        modules =
          [
            ./sys/overlays.nix
            ./sys/home.nix
            ./sys/unfree.nix
            ./pkg/common.nix
            ./pkg/zsh.nix
            ./pkg/yazi.nix
            ./pkg/vscode.nix
          ]
          ++ configs;
        extraSpecialArgs = args;
      };
  in {
    homeConfigurations = {
      "${userConfig.username}@${userConfig.darwinHost}" = hmConfig {
        configs = [
          ./pkg/darwin.nix
          ./pkg/aerospace.nix
        ];
        args = darwinArgs;
      };
      "${userConfig.username}@${userConfig.linuxHost}" = hmConfig {
        configs = [
          ./sys/gtk.nix
          ./pkg/linux.nix
          ./pkg/bspwm.nix
        ];
        args = linuxArgs;
      };
    };

    darwinConfigurations.${userConfig.darwinHost} = nix-darwin.lib.darwinSystem {
      modules = [
        ./sys/nixcommand.nix
        ./sys/configuration-darwin.nix
        ./pkg/brew.nix
      ];
      specialArgs = darwinArgs;
    };

    nixosConfigurations.${userConfig.linuxHost} = nixpkgs.lib.nixosSystem {
      modules = [
        ./sys/unfree.nix
        ./sys/nixcommand.nix
        ./sys/configuration.nix
        ./sys/hardware-configuration.nix
      ];
      specialArgs = linuxArgs;
    };
  };
}
