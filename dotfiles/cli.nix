{
  pkgs,
  canvas-cli,
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
    bat
    binutils
    file
    gdb
    ghidra
    jq
    just
    ltrace
    neofetch
    pythonWithPackages
    ripgrep
    strace
    unzip
    wget
    uv
    zellij
    zip
  ];
}