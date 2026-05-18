{
  inputs,
  pkgs,
  ...
}:

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

    git = {
      enable = true;
      lfs = {
        enable = true;
        enablePureSSHTransfer = true;
      };
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        gcc
      ];
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
    postgresql
    podman-tui
    # jre17_minimal
    crun
    jetbrains.datagrip
    rustup
    rust-analyzer
    lua
    luarocks
    luajitPackages.tree-sitter-cli
    statix
    nixfmt
    openssl
    gh
    gcc
    gh-dash
    inputs.snitch.packages.${pkgs.stdenv.hostPlatform.system}.default
    lazydocker
    dockmate
    sqlite
    abduco
  ];
}
