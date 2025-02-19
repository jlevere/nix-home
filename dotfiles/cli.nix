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
    awscli2
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
    nil
    netcat
    pythonWithPackages
    ripgrep
    rustscan
    socat
    strace
    go-task
    tcpdump
    terraform
    inetutils
    unzip
    usbutils
    wget
    zellij
    zip
  ];
}
