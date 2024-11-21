{
  nixpkgs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./cli.nix
  ];

  home.keyboard = null;

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    open-sans
  ];

  fonts.fontconfig.enable = true;

  # programs.firefox = {
  #   enable = true;
  # };

  programs.direnv = {
    enable = true;
    # enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  manual.manpages.enable = true;

  programs.man = {
    enable = true;
    generateCaches = true;
  };

  programs.git = {
    enable = true;
    ignores = [
      ".direnv"
    ];
    userEmail = "71566629+jLevere@users.noreply.github.com";
    userName = "jLevere";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      "g" = "git";
    };
    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
  };

  home.activation.configure-tide = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.fish}/bin/fish -c "tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Solid --prompt_connection_andor_frame_color=Dark --prompt_spacing=Sparse --icons='Many icons' --transient=No"
  '';

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      default_layout = "compact";
      default_shell = "fish";
      pane_frames = false;
    };
  };

  programs.nix-index.enable = true;

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