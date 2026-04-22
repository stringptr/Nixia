{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  hardware.bluetooth.enable = true;
  services = {
    resolved = {
      enable = true;
      settings.Resolve = {
        DNS = [ "127.0.0.1:53" "[::1]:53" ];
        FallbackDNS = [ "" ];
        DNSStubListener = true;
        DNSOverTLS = false;
        DNSSEC = false;
        Domains = [ "~." ];
      };
    };

    tailscale = {
      enable = true;
      openFirewall = true;
    };

    dnscrypt-proxy = {
      enable = true;
      settings = {
        server_names = [ "quad9-dnscrypt-ip4-filter-ecs-pri" "quad9-dnscrypt-ip6-filter-ecs-pri" ];
        listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];
        enable_hot_reload = true;
        max_clients = 250;
        dnscrypt_servers = true;
        doh_servers = true;
        odoh_servers = false;
        require_dnssec = true;
        require_nolog = true;
        require_nofilter = true;
        http3 = true;
        ignore_system_dns = true;
        block_unqualified = true;
        block_undelegated = true;
        cache = true;
        cache_size = 4096;
        cache_min_ttl = 2400;
        cache_max_ttl = 86400;
        cache_neg_min_ttl = 60;
        cache_neg_max_ttl = 600;
        broken_implementations.fragments_blocked = [
          "cisco"
          "cisco-ipv6"
          "cisco-familyshield"
          "cisco-familyshield-ipv6"
          "cisco-sandbox"
          "cleanbrowsing-adult"
          "cleanbrowsing-adult-ipv6"
          "cleanbrowsing-family"
          "cleanbrowsing-family-ipv6"
          "cleanbrowsing-security"
          "cleanbrowsing-security-ipv6"
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    net-tools
    spoofdpi
  ];

  systemd.user.services.spoofdpi = {
    description = "SpoofDPI AutoStart";
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.spoofdpi}/bin/spoofdpi --listen-addr 127.0.0.1:1080 --dns-addr 127.0.0.1:53";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}

