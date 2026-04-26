{ inputs, pkgs, config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];
  boot.blacklistedKernelModules = [ "nouveau" ];
  nixpkgs.config.nvidia.acceptLicense = true;

  environment.systemPackages = with pkgs; [
    powertop
  ];

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;
      nvidiaSettings = true;

      prime = {
        offload.enable = true;
        nvidiaBusId = "PCI:1@0:0:0";
        amdgpuBusId = "PCI:5@0:0:0";
      };
    };

    nvidia-container-toolkit.enable = true;
  };


  systemd.services.nvidia-mps = {
    description = "NVIDIA CUDA Multi-Process Service";
    after = [ "nvidia-persistenced.service" ];
    requires = [ "nvidia-persistenced.service" ];
    wantedBy = [ "multi-user.target" ];
    path = [ config.hardware.nvidia.package.bin ];
    serviceConfig = {
      Type = "forking";
      ExecStart = "${config.hardware.nvidia.package.bin}/bin/nvidia-cuda-mps-control -d";
      ExecStop = "${pkgs.writeShellScript "nvidia-mps-stop" ''
        echo quit | ${config.hardware.nvidia.package.bin}/bin/nvidia-cuda-mps-control
      ''}";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  systemd.services.disable-amd-turbo = {
    description = "Disable AMD CPU Turbo Boost";

    # Ensure it runs during boot and after a sleep/resume cycle
    wantedBy = [ "multi-user.target" "post-resume.target" ];
    after = [ "multi-user.target" "post-resume.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeScript "disable-boost.sh" ''
        #!${pkgs.stdenv.shell}
        if [ -f /sys/devices/system/cpu/cpufreq/boost ]; then
          echo 0 > /sys/devices/system/cpu/cpufreq/boost
          echo "AMD Turbo Boost disabled successfully."
        else
          echo "Error: /sys/devices/system/cpu/cpufreq/boost not found."
          exit 1
        fi
      '';
    };
  };
}
