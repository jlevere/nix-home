{
  nixpkgs,
  pkgs,
  ...
}: {
  imports = [
    ./pkgs.nix
    ./fish.nix
    ./git.nix
  ];

  home.keyboard = null;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    gyre-fonts
    nerd-fonts.caskaydia-cove
    open-sans
    doulos-sil
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  manual.manpages.enable = true;

  programs.man = {
    enable = true;
    generateCaches = true;
  };

  programs.zellij = {
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      default_layout = "compact";
      default_shell = "fish";
      pane_frames = false;
    };
  };

  programs.home-manager.enable = true;

  nix.channels = {
    inherit nixpkgs;
  };

  nix.registry = {
    np = {
      from = {
        type = "indirect";
        id = "np";
      };
      flake = nixpkgs;
    };
    nixpkgs = {
      from = {
        type = "indirect";
        id = "nixpkgs";
      };
      flake = nixpkgs;
    };
  };
}
