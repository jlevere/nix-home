{
  pkgs,
  canvas-cli,
  alejandra,
  config,
  ...
}: {
  home.packages = with pkgs; let
    pythonWithPackages = python3.withPackages (ps:
      with ps; [
        requests
        pwntools
      ]);
  in [
    alejandra
    bat
    binutils
    file
    gdb
    ghidra
    jq
    just
    ltrace
    neofetch
    canvas-cli.packages.x86_64-linux.default
    pythonWithPackages
    ripgrep
    strace
    unzip
    wget
    zellij
    zip
  ];
}