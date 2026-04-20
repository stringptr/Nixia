{ inputs, pkgs, config, ... }:

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
}
