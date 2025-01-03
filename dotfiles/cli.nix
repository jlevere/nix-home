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
    canvas-cli.packages.x86_64-linux.default
    file
    gdb
    ghidra
    gnumake
    jq
    just
    ltrace
    neofetch
    netcat
    pythonWithPackages
    ripgrep
    socat
    strace
    tcpdump
    unzip
    wget
    zellij
    zip
  ];
}
