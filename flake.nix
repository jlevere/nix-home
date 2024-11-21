{
  description = "my home config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    canvas-cli = {
      url = "github:mbund/canvas-cli";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-index-database,
    ...
  } @ attrs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfreePredicate = pkg:
        builtins.elem (nixpkgs.lib.getName pkg) [
          "terraform"
        ];
      overlays = [
        (
          final: prev: let
            nmpkgs = networkmanager-nixpkgs.legacyPackages.x86_64-linux;
          in {
            inherit (nmpkgs) wpa_supplicant;
          }
        )
      ];
    };
  in {
    homeConfigurations."admin" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = attrs;
      modules = [
        ./home
        nix-index-database.hmModules.nix-index
        {home.username = "admin";}
        {home.stateVersion = "24.05";}
        {home.homeDirectory = "/home/admin";}
      ];
    };
  };
}