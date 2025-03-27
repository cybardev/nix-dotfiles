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
          config,
          args,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [
            ./packages/nonfree.nix
            config
          ];
          extraSpecialArgs = args;
        };
      hmConfigDarwin =
        { ... }:
        hmConfig {
          system = "aarch64-darwin";
          config = ./system/home-darwin.nix;
          args = genArgs { host = userConfig.darwinHost; };
        };
      hmConfigLinux =
        { surfaceKernel }:
        hmConfig {
          system = "x86_64-linux";
          config = ./system/home-linux.nix;
          args = genArgs {
            host = userConfig.linuxHost;
            inherit surfaceKernel;
          };
        };
      nixConfigDarwin =
        { ... }:
        nix-darwin.lib.darwinSystem {
          modules = [ ./configuration-darwin.nix ];
          specialArgs = genArgs { host = userConfig.darwinHost; };
        };
      nixConfigLinux =
        { surfaceKernel }:
        nixpkgs.lib.nixosSystem {
          modules =
            [ ./configuration.nix ]
            ++ (nixpkgs.lib.optional surfaceKernel inputs.nixos-hardware.nixosModules.microsoft-surface-common);
          specialArgs = genArgs {
            host = userConfig.linuxHost;
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
