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
    act
    alejandra.packages.x86_64-linux.default
    bat
    binutils
    file
    gdb
    ghidra
    gnumake
    jq
    just
    ltrace
    neofetch
    netcat
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
