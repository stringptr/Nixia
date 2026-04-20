{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  nix.settings.substituters = [ "https://cache.garnix.io" "https://attic.xuyh0120.win/lantian" ];
  nix.settings.trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

  boot.initrd.systemd.enable = true;
  boot.kernel.sysctl = {
    "vm.laptop_mode" = 5;
  };

  boot.loader = {
    limine = {
      enable = true;
      enableEditor = true;
      style = {
        graphicalTerminal = {
          background = "ff00000000";
          brightBackground = "ff00000000";
          foreground = "ffffff";
        };
        interface = {
          branding = "Pick Your Poison!";
        };
        wallpapers = [ "/sys/devices/system/cpu/cpufreq/boost" ];
      };
      extraConfig = ''
      verbose: yes
      editor_enabled: yes
      '';
      extraEntries = ''
      /Artixia
          //Linux-Cachy
          protocol: linux
          path: boot():/artix/vmlinuz-linux-cachyos
          cmdline: root=UUID=af98cc9a-83b7-4887-bff4-8f1999300b8c rw rootflags=subvol=/@artix/@ acpi_backlight=native zswap.enabled=1 zswap.shrinker_enabled=1 z swap.compressor=lz4 zswap.max_pool_percent=20 zswap.zpool=zsmalloc nowatchdog pcie_aspm.policy=powersupersave nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvid ia.NVreg_EnableGpuFirmware=1 nvidia.NVreg_PreserveVideoMemoryAllocations=1 resume=UUID=af98cc9a-83b7-4887-bff4-8f1999300b8c resume_offset=36112418 ibt=off psi=1
          module_path: boot():/artix/booster-linux-cachyos.img
          module_path: boot():/amd-ucode.img

      /Recovery
          //Artix
          protocol: linux
          path: boot():/live/artix/vmlinuz-linux
          module_path: boot():/live/artix/booster-linux-universal.img
          cmdline: img_dev=/dev/nvme0n1p1 img_loop=/live/artix/artix-openrc.iso
          //Nix
          protocol: linux
          path: boot():/live/nix/nix-initrd
          module_path: boot():/live/nix/nix-bzImage
          cmdline: img_dev=/dev/nvme0n1p1 img_loop=/live/nix/nix.iso
        //GParted
        protocol: linux
        path: boot():/live/gparted/vmlinuz
        module_path: boot():/live/gparted/initrd.img
        cmdline: img_dev=/dev/nvme0n1p1 img_loop=/live/gparted/gparted.iso
      /EFI fallback
      comment: Default EFI loader
      comment: order-priority=10
      protocol: efi_chainload
      image_path: boot():/EFI/Boot/bootx64.efi
      '';
    };
    efi.canTouchEfiVariables = true;
  };

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
  boot.kernelParams = [ "acpi_backlight=native" "zswap.enabled=1" "zswap.shrinker_enabled=1" "zswap.compressor=lz4" "zswap.max_pool_percent=20" "zswap.zpool=zsmalloc" "nowatchdog" "pcie_aspm.policy=powersupersave" "nvidia_drm.modeset=1" "nvidia_drm.fbdev=1" "nvidia.NVreg_EnableGpuFirmware=1" "nvidia.NVreg_PreserveVideoMemoryAllocations=1" "resume=UUID=af98cc9a-83b7-4887-bff4-8f1999300b8c" "resume_offset=36112418" "ibt=off" "psi=1" ];
}
