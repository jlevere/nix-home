{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      "g" = "git";
      "gs" = "git status";
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
      code = {
        body = "/mnt/c/Users/winlap1/AppData/local/Programs/Microsoft\\ VS\\ Code/bin/code $argv";
      };
      cursor = {
        body = "/mnt/c/Users/winlap1/AppData/Local/Programs/cursor/resources/app/bin/cursor $argv";
      };
      clip = {
        body = "/mnt/c/windows/System32/clip.exe $argv";
      };
      fish_greeting = {
        body = "";
      };
    };
  };

  home.activation.configure-tide = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.fish}/bin/fish -c "tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_connection_andor_frame_color=Dark --prompt_spacing=Compact --icons='Many icons' --transient=No"
  '';
}
