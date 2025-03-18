{
  description = "cybardev/nix-dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cypkgs = {
      url = "github:cybardev/nix-channel/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs-darwin,
      ...
    }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs-darwin.legacyPackages.${system};
    in
    {
      homeConfigurations."sage" = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

      darwinConfigurations."blade" = inputs.nix-darwin.lib.darwinSystem {
        modules = [ ./configuration-darwin.nix ];
      };
    };
}
