{
  description = "my home config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };
    canvas-cli = {
      url = "github:mbund/canvas-cli";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
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
