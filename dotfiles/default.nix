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

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    open-sans
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

  home.file."${config.home.homeDirectory}/.ssh/allowed_signers".text = let
    pubkey = builtins.readFile (builtins.fetchurl {
      url = "https://github.com/jLevere.keys";
      sha256 = "1g87mxaaizyn8y5l0mdkxh14gywp4xjxlhxx2327m1q528bzn7gp";
    });
  in "71566629+jLevere@users.noreply.github.com ${pubkey}";

  programs.git = {
    enable = true;
    ignores = [
      ".direnv"
    ];
    userEmail = "71566629+jLevere@users.noreply.github.com";
    userName = "jLevere";

    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
      user.signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    };
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
    functions = {
      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };
    };
  };

  home.activation.configure-tide = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.fish}/bin/fish -c "tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_connection_andor_frame_color=Dark --prompt_spacing=Compact --icons='Many icons' --transient=No"
  '';

  programs.zellij = {
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
