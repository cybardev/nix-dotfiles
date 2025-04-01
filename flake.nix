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
        { host, ... }@extraArgs:
        {
          inherit inputs;
          inherit extraArgs;
          inherit userConfig;
          hostName = host;
        };
      hmConfig =
        {
          system,
          configs,
          args,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./sys/nonfree.nix
            ./sys/home.nix
            ./pkg/common.nix
            ./pkg/zsh.nix
            ./pkg/yazi.nix
            ./pkg/vscode.nix
          ] ++ configs;
          extraSpecialArgs = args;
        };
      hmConfigDarwin =
        { ... }:
        hmConfig {
          system = userConfig.darwinSystem;
          configs = [
            ./pkg/darwin.nix
            ./pkg/aerospace.nix
          ];
          args = genArgs {
            host = userConfig.darwinHost;
            home = "/Users/${userConfig.username}";
          };
        };
      hmConfigLinux =
        { surfaceKernel }:
        hmConfig {
          system = userConfig.linuxSystem;
          configs = [
            ./pkg/linux.nix
            ./pkg/bspwm.nix
          ];
          args = genArgs {
            host = userConfig.linuxHost;
            home = "/home/${userConfig.username}";
            inherit surfaceKernel;
          };
        };
      nixConfigDarwin =
        { ... }:
        nix-darwin.lib.darwinSystem {
          modules = [
            ./sys/nonfree.nix
            ./sys/configuration-darwin.nix
            ./pkg/brew.nix
          ];
          specialArgs = genArgs {
            host = userConfig.darwinHost;
            home = "/Users/${userConfig.username}";
            system = userConfig.darwinSystem;
          };
        };
      nixConfigLinux =
        { surfaceKernel }:
        nixpkgs.lib.nixosSystem {
          modules =
            [
              ./sys/nonfree.nix
              ./sys/configuration.nix
              ./sys/hardware-configuration.nix
            ]
            ++ (nixpkgs.lib.optional surfaceKernel inputs.nixos-hardware.nixosModules.microsoft-surface-common);
          specialArgs = genArgs {
            host = userConfig.linuxHost;
            home = "/home/${userConfig.username}";
            system = userConfig.linuxSystem;
            inherit surfaceKernel;
          };
        };
    in
    {
      homeConfigurations = {
        darwin = hmConfigDarwin { };
        linux = hmConfigLinux { surfaceKernel = false; };
        linux-surface = hmConfigLinux { surfaceKernel = true; };
      };

      darwinConfigurations = {
        darwin = nixConfigDarwin { };
      };

      nixosConfigurations = {
        linux = nixConfigLinux { surfaceKernel = false; };
        linux-surface = nixConfigLinux { surfaceKernel = true; };
      };
    };
}
