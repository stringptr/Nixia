{
  pkgs,
  ...
}:

{
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

  systemd.services = {
    restart-asusd = {
      description = "Restart asusd to apply Nix configuration";
      after = [ "asusd.service" ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.writeShellScript "restart-asusd" ''
           # Check if asusd is actually running first
           # if /run/current-system/sw/bin/systemctl is-active --quiet asusd.service; then
           #   echo "Reloading asusd to apply Nix configuration..."
           #   /run/current-system/sw/bin/systemctl try-restart asusd.service
           # fi
           cp -f /etc/asusd/asusd.conf /etc/asusd/asusd.ron
           cp -f /etc/asusd/fan_curves.conf /etc/asusd/fan_curves.ron
          /run/current-system/sw/bin/asusctl fan-curve --mod-profile quiet --fan gpu --data 43c:0%,46c:25%,60c:40%,65c:50%,70c:60%,75c:69%,80c:70%,90c:80%
          /run/current-system/sw/bin/asusctl fan-curve --mod-profile quiet --fan cpu --data 43c:0%,46c:25%,60c:40%,65c:50%,70c:60%,75c:69%,80c:70%,90c:80%
          /run/current-system/sw/bin/asusctl fan-curve --mod-profile balanced --fan cpu --data 43c:0%,46c:25%,60c:40%,65c:50%,70c:60%,75c:69%,80c:70%,90c:80%
          /run/current-system/sw/bin/asusctl fan-curve --mod-profile balanced --fan gpu --data 43c:0%,46c:25%,60c:40%,65c:50%,70c:60%,75c:69%,80c:70%,90c:80%
          /run/current-system/sw/bin/asusctl fan-curve --mod-profile performance --fan gpu --data 45c:0%,46c:30%,50c:40%,60c:50%,65c:65%,70c:85%,75c:90%,90c:95%
          /run/current-system/sw/bin/asusctl fan-curve --mod-profile performance --fan cpu --data 45c:0%,46c:30%,50c:40%,60c:50%,65c:65%,70c:85%,75c:90%,90c:95%
          /run/current-system/sw/bin/asusctl fan-curve --enable-fan-curves true --mod-profile quiet && asusctl fan-curve --enable-fan-curves true --mod-profile balanced && asusctl fan-curve --enable-fan-curves true --mod-profile performance
          /run/current-system/sw/bin/asusctl battery limit 60
        ''}";
      };
    };
  };
}
