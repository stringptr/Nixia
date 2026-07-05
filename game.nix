{
  pkgs,
  ...
}:

{
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };

  security.rtkit.enable = true;

  services.pipewire = {
    extraConfig.pipewire."99-low-latency-and-higher-resampling-quality" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [
          44100
          48000
          88200
          96000
          176400
          192000
        ];
        "default.clock.quantum" = 64;
        "default.clock.min-quantum" = 64;
        "default.clock.max-quantum" = 64;
        "stream.properties" = {
          "resample.quality" = 10;
        };
        "default.resample.method" = "speex-float-10";
      };
      "context.modules" = [
        {
          name = "libpipewire-module-rt";
          args = {
            "nice.level" = -11; # Sets the application thread priority
            "rt.prio" = 5; # Sets the realtime priority of the data thread
          };
          flags = [
            "ifexists"
            "nofail"
          ];
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    gamemode
    protontricks
    winetricks

    openal-soft

    gamescope
    umu-launcher
    lutris-free
  ];
}
