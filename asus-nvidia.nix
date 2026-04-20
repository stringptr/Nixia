{ inputs, pkgs, config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];
  boot.blacklistedKernelModules = [ "nouveau" ];
  nixpkgs.config.nvidia.acceptLicense = true;
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

  services = {
    supergfxd.enable = true;
    asusd = {
      enable = true;
      fanCurvesConfig.text = ''
      (
          profiles: (
              balanced: [
                  (
                      fan: CPU,
                      pwm: (0%, 25%, 40%, 50%, 60%, 69%, 70%, 89%),
                      temp: (43, 46, 60, 65, 70, 75, 80, 90),
                      enabled: true,
                  ),
                  (
                      fan: GPU,
                      pwm: (0%, 25%, 40%, 50%, 60%, 69%, 70%, 89%),
                      temp: (43, 46, 60, 65, 70, 75, 80, 90),
                      enabled: true,
                  ),
              ],
              performance: [
                  (
                      fan: CPU,
                      pwm: (0%, 30%, 40%, 50%, 65%, 85%, 90%, 95%),
                      temp: (45, 46, 50, 60, 65, 70, 75, 90),
                      enabled: true,
                  ),
                  (
                      fan: GPU,
                      pwm: (0%, 30%, 40%, 50%, 65%, 85%, 90%, 95%),
                      temp: (45, 46, 50, 60, 65, 70, 75, 90),
                      enabled: true,
                  ),
              ],
              quiet: [
                  (
                      fan: CPU,
                      pwm: (0%, 25%, 40%, 50%, 60%, 69%, 70%, 89%),
                      temp: (44, 46, 60, 65, 70, 70, 80, 90),
                      enabled: true,
                  ),
                  (
                      fan: GPU,
                      pwm: (0%, 25%, 40%, 50%, 60%, 69%, 70%, 89%),
                      temp: (44, 46, 60, 65, 70, 70, 80, 90),
                      enabled: true,
                  ),
              ],
              custom: [],
          ),
      )
      '';
      asusdConfig.text = ''
      (
          charge_control_end_threshold: 60,
          disable_nvidia_powerd_on_battery: true,
          ac_command: "",
          bat_command: "",
          platform_profile_linked_epp: true,
          platform_profile_on_battery: Quiet,
          change_platform_profile_on_battery: true,
          platform_profile_on_ac: Balanced,
          change_platform_profile_on_ac: true,
          profile_quiet_epp: Power,
          profile_balanced_epp: Power,
          profile_custom_epp: Quiet,
          profile_performance_epp: BalancePerformance,
          ac_profile_tunings: {
              Performance: (
                  enabled: false,
                  group: {},
              ),
              LowPower: (
                  enabled: false,
                  group: {},
              ),
              Quiet: (
                  enabled: false,
                  group: {},
              ),
              Balanced: (
                  enabled: false,
                  group: {},
              ),
          },
          dc_profile_tunings: {
              Balanced: (
                  enabled: false,
                  group: {},
              ),
              Quiet: (
                  enabled: false,
                  group: {},
              ),
          },
          armoury_settings: {},
      )
      '';
    };
  };
}
