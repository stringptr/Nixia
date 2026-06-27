{
  inputs,
  pkgs,
  ...
}:

{
  # nixpkgs.overlays = [
  #   (self: super: {
  #     qemu = super.qemu.override { venusSupport = true; };
  #   })
  # ];

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
    # inputs.tgt.packages.${stdenv.hostPlatform.system}.default
    ayugram-desktop
    # librewolf
    zoom-us
    kdePackages.kamoso
    gitlogue
    gnome-network-displays
    weathr
    qbittorrent
    nemu
    virtiofsd
    virt-viewer
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = with pkgs; [ virtiofsd ];
        runAsRoot = false;
        swtpm = {
          enable = true;
        };
        # package = pkgs.qemu.override {
        #   venusSupport = true;
        # };
      };
    };

    kvmgt.enable = true;
    # useEFIBoot = true;
    # tpm.enable = true;
    # useSecureBoot = true;
  };

  programs = {
    virt-manager = {
      enable = true;
    };
  };

  # services = {
  #   qbittorrent = {
  #     enable = true;
  #   };
  # };
}
