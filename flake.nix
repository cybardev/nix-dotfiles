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
      userNickname = "Sheikh";
      userName = "sage";
      darwinHost = "blade";
      linuxHost = "forest";
      userLocale = "en_CA.UTF-8";
      userTZ = "America/Halifax";
      nixConfigDir = "~/.config/nixos";
      genArgs =
        { host, ... }@extraArgs:
        {
          inherit extraArgs;
          inherit inputs;
          inherit userTZ;
          inherit userLocale;
          inherit nixConfigDir;
          inherit userNickname;
          inherit userName;
          hostName = host;
        };
      hmConfig =
        { ... }@args:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = args.system; };
          modules = [
            ./packages/nonfree.nix
            args.config
          ];
          extraSpecialArgs = genArgs (
            if args ? surfaceKernel then
              {
                host = args.host;
                surfaceKernel = args.surfaceKernel;
              }
            else
              { host = args.host; }
          );
        };
      hmConfigLinux =
        { surfaceKernel }:
        hmConfig {
          system = "x86_64-linux";
          config = ./system/home-linux.nix;
          host = linuxHost;
          inherit surfaceKernel;
        };
    in
    {
      homeConfigurations = {
        darwin = hmConfig {
          system = "aarch64-darwin";
          config = ./system/home-darwin.nix;
          host = darwinHost;
        };
        linux = hmConfigLinux { surfaceKernel = false; };
        linux-surface = hmConfigLinux { surfaceKernel = true; };
      };

      darwinConfigurations = {
        darwin = nix-darwin.lib.darwinSystem {
          modules = [ ./configuration-darwin.nix ];
          specialArgs = genArgs { host = darwinHost; };
        };
      };

      nixosConfigurations =
        let
          makeLinuxConfig =
            { surfaceKernel }:
            nixpkgs.lib.nixosSystem {
              modules =
                [ ./configuration.nix ]
                ++ (nixpkgs.lib.optional surfaceKernel inputs.nixos-hardware.nixosModules.microsoft-surface-common);
              specialArgs = genArgs {
                host = linuxHost;
                inherit surfaceKernel;
              };
            };
        in
        {
          linux = makeLinuxConfig { surfaceKernel = false; };
          linux-surface = makeLinuxConfig { surfaceKernel = true; };
        };
    };
}
