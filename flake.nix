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
        nixConfigDir = "~/.config/nixos";
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
        { ... }@args:
        let
          pkgs = import nixpkgs { system = args.system; };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./packages/nonfree.nix
            args.config
          ];
          extraSpecialArgs =
            genArgs { host = args.host; }
            // pkgs.lib.optionalAttrs (args ? surfaceKernel) { surfaceKernel = args.surfaceKernel; };
        };
      hmConfigLinux =
        { surfaceKernel }:
        hmConfig {
          system = "x86_64-linux";
          config = ./system/home-linux.nix;
          host = userConfig.linuxHost;
          inherit surfaceKernel;
        };
      makeLinuxConfig =
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
        darwin = hmConfig {
          system = "aarch64-darwin";
          config = ./system/home-darwin.nix;
          host = userConfig.darwinHost;
        };
        linux = hmConfigLinux { surfaceKernel = false; };
        linux-surface = hmConfigLinux { surfaceKernel = true; };
      };

      darwinConfigurations = {
        darwin = nix-darwin.lib.darwinSystem {
          modules = [ ./configuration-darwin.nix ];
          specialArgs = genArgs { host = userConfig.darwinHost; };
        };
      };

      nixosConfigurations = {
        linux = makeLinuxConfig { surfaceKernel = false; };
        linux-surface = makeLinuxConfig { surfaceKernel = true; };
      };
    };
}
