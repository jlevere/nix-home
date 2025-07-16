{config, ...}: {
  home.file."${config.home.homeDirectory}/.ssh/allowed_signers".text = let
    pubkey = builtins.readFile (builtins.fetchurl {
      url = "https://github.com/jLevere.keys";
      sha256 = "0jff3j8dyypyrrmpi0i7d0rj1bk0qr03m2ckvvi3n8s8xhc5d6ky";
    });
  in "71566629+jLevere@users.noreply.github.com ${pubkey}";

  programs.git = {
    enable = true;
    ignores = [
      ".direnv"
      ".envrc"
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

  services.ssh-agent = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks."*" = {
      identityFile = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
      identitiesOnly = true;
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}
