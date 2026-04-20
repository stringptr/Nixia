{ inputs, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      withPython3 = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
    lazygit = {
      enable = true;
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      networkSocket.openFirewall = true;
    };
    docker = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    uv
    bun
    go
    gow
    python313
    tree-sitter
    podman-tui
    jre17_minimal
    crun
  ];
}
