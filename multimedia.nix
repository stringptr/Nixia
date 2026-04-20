{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    imv
    mpv
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
}
