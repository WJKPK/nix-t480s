{ ... }: {
  targets.genericLinux.enable = true;
  imports = [
    ./programs/standalone-terminal.nix
    ./standalone.nix
  ];
  home = {
    username = "wkrupski";
    homeDirectory = "/home/wkrupski";
  };
}
