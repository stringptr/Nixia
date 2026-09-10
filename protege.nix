{
  pkgs,
  ...
}:

{
  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        libxext
        libxtst
        libxi
        libx11
        libxrender

        freetype
        fontconfig
      ];
    };
  };
}
