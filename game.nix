{
  pkgs,
  inputs,
  ...
}:

{
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };

  systemd.settings.Manager = {
    DefaultLimitNOFILE = 524288;
  };
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "524288";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "524288";
    }
  ];

  # security.rtkit.enable = true;
  hardware.graphics.enable32Bit = true;

  # programs.steam.enable = true;

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
          352800
          384000
        ];
        # "default.clock.quantum" = 64;
        # "default.clock.min-quantum" = 64;
        # "default.clock.max-quantum" = 64;
        "stream.properties" = {
          "resample.quality" = 10;
        };
        "default.resample.method" = "speex-float-10";
      };
      # "context.modules" = [
      #   {
      #     name = "libpipewire-module-rt";
      #     args = {
      #       "nice.level" = -11;
      #       "rt.prio" = 5;
      #     };
      #     flags = [
      #       "ifexists"
      #       "nofail"
      #     ];
      #   }
      # ];
    };
  };

  environment.systemPackages = with pkgs; [

    lutris-free
    gamemode
    protontricks
    winetricks
    wineWow64Packages.full

    openal-soft

    mangohud
    mangojuice

    gamescope
    umu-launcher
    (inputs.prismlauncher.packages.${pkgs.system}.prismlauncher.override {
      jdks = [ temurin-jre-bin-21 ];
    })
  ];

  programs = {
    gamemode = {
      enable = true;
      enableRenice = true;
    };

    gamescope = {
      enable = true;
      enableWsi = true;
      capSysNice = true;
    };

    #   nix-ld = {
    #     libraries = with pkgs; [
    #       gamemode
    #       protontricks
    #       winetricks
    #       wineWow64Packages.full
    #
    #       openal-soft
    #
    #       mangohud
    #       mangojuice
    #
    #       gamescope
    #       umu-launcher
    #       vulkan-tools
    #     ];
    #   };
  };
}
