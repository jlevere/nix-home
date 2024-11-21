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
    canvas-cli.packages.x86_64-linux.default
    ffmpeg
    file
    gdb
    ghidra
    jq
    just
    neofetch
    pythonWithPackages
    ripgrep
    strace
    typst
    typst-lsp
    unzip
    wget
    zellij
    zip
  ];
}