{ inputs, pkgs, ... }:

{
  imports = [
    inputs.spicetify-nix.nixosModules.spicetify
  ];

  environment.systemPackages = with pkgs; [
    imv
    mpv
    qpwgraph
    easyeffects
    lsp-plugins
    obs-studio
  ];

  services = {
    pipewire = {
      audio.enable = true;
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };
  };

  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
    ];
  };
}
