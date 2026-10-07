{
  inputs,
  pkgs,
  ...
}:

{
  # imports = [
  #   inputs.zen-browser.homeModules.beta
  # ];

  home = {
    preferXdgDirectories = true;

    packages = with pkgs; [
      libqalculate
      libcava
      aubio
      ddcutil
      app2unit
      lm_sensors
      libqalculate
      cliphist

      # hicolor-icon-theme
      papirus-icon-theme

      kdePackages.breeze-icons
      kdePackages.breeze
    ];
  };

  programs = {
    quickshell = {
      enable = true;
      package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.withModules (
        with pkgs;
        [
          qt6.qtdeclarative
          qt6.qtmultimedia
          qt6.qtsvg
          qt6.qtbase
          qt6.qtwayland
          qt6.qt5compat

          qt6.qtpositioning
        ]
      );
      activeConfig = "caelestia";
      systemd.enable = true;
    };

    # zen-browser = {
    #   enable = true;
    #   setAsDefaultBrowser = true;
    #
    #   profiles.default = {
    #     sine.enable = true;
    #     settings = {
    #       "app.normandy.api_url" = "";
    #       "app.update.checkInstallTime" = false;
    #       "app.update.disabledForTesting" = true;
    #       "browser.cache.disk.enable" = false;
    #       "browser.contentblocking.category" = "strict";
    #       "browser.dom.window.dump.enabled" = true;
    #       "browser.download.start_downloads_in_tmp_dir" = true;
    #       "browser.link.open_newwindow" = 3;
    #       "browser.link.open_newwindow.restriction" = 0;
    #       "browser.newtabpage.activity-stream.asrouter.providers.cfr" = "null";
    #       "browser.newtabpage.activity-stream.asrouter.providers.cfr-fxa" = "null";
    #       "browser.newtabpage.activity-stream.asrouter.providers.message-groups" = "null";
    #       "browser.newtabpage.activity-stream.asrouter.providers.messaging-experiments" = "null";
    #       "browser.newtabpage.activity-stream.asrouter.providers.snippets" = "null";
    #       "browser.newtabpage.activity-stream.asrouter.providers.whats-new-panel" = "null";
    #       "browser.newtabpage.activity-stream.default.sites" = "";
    #       "browser.newtabpage.activity-stream.discoverystream.config" = "[]";
    #       "browser.newtabpage.activity-stream.feeds.snippets" = false;
    #       "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
    #       "browser.newtabpage.activity-stream.fxaccounts.endpoint" = "";
    #       "browser.newtabpage.activity-stream.tippyTop.service.endpoint" = "";
    #       "browser.privatebrowsing.resetPBM.enabled" = true;
    #       "browser.safebrowsing.downloads.remote.enabled" = false;
    #       "browser.search.update" = false;
    #       "browser.sessionstore.interval" = 60000;
    #       "browser.sessionstore.resume_from_crash" = false;
    #       "browser.shell.checkDefaultBrowser" = false;
    #       "browser.startup.homepage_override.mstone" = "ignore";
    #       "browser.startup.page" = 0;
    #       "browser.uitour.enabled" = false;
    #       "browser.urlbar.quicksuggest.enabled" = false;
    #       "browser.warnOnQuit" = false;
    #       "browser.webapps.checkForUpdates" = 0;
    #       "datareporting.healthreport.documentServerURI" = "http://%(server)s/dummy/healthreport/";
    #       "datareporting.healthreport.logging.consoleEnabled" = false;
    #       "datareporting.healthreport.service.enabled" = false;
    #       "datareporting.healthreport.service.firstRun" = false;
    #       "datareporting.healthreport.uploadEnabled" = false;
    #       "datareporting.policy.dataSubmissionEnabled" = false;
    #       "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
    #       "devtools.console.stdout.chrome" = true;
    #       "dom.ipc.reportProcessHangs" = false;
    #       "dom.text_fragments.create_text_fragment.enabled" = true;
    #       "editor.truncate_user_pastes" = false;
    #       "extensions.autoDisableScopes" = 0;
    #       "extensions.enabledScopes" = 5;
    #       "extensions.installDistroAddons" = false;
    #       "extensions.update.enabled" = false;
    #       "extensions.update.notifyUser" = false;
    #       "focusmanager.testmode" = true;
    #       "general.useragent.updates.enabled" = false;
    #       "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
    #       "geo.provider.testing" = true;
    #       "geo.wifi.scan" = false;
    #       "gfx.canvas.accelerated.cache-size" = 512;
    #       "hangmonitor.timeout" = 0;
    #       "idle.lastDailyNotification" = -1;
    #       "marionette.port" = 0;
    #       "media.gmp-manager.updateEnabled" = false;
    #       "media.sanity-test.disabled" = true;
    #       "network.auth.subresource-http-auth-allow" = 1;
    #       "network.dns.disablePrefetch" = true;
    #       "network.dns.disablePrefetchFromHTTPS" = true;
    #       "network.http.pacing.requests.enabled" = false;
    #       "network.http.referer.XOriginTrimmingPolicy" = 2;
    #       "network.manage-offline-status" = false;
    #       "network.predictor.enable-prefetch" = false;
    #       "network.predictor.enabled" = false;
    #       "network.prefetch-next" = false;
    #       "network.sntp.pools" = "%(server)s";
    #       "permissions.default.desktop-notification" = 2;
    #       "permissions.default.geo" = 2;
    #       "permissions.manager.defaultsUrl" = "";
    #       "privacy.history.custom" = true;
    #       "remote.active-protocols" = 1;
    #       "remote.log.level" = "Info";
    #       "security.OCSP.enabled" = 0;
    #       "security.certerrors.mitm.priming.enabled" = false;
    #       "security.pki.crlite_mode" = 2;
    #       "services.settings.server" = "data:,#remote-settings-dummy/v1";
    #       "signon.formlessCapture.enabled" = false;
    #       "signon.privateBrowsingCapture.enabled" = false;
    #       "startup.homepage_welcome_url" = "about:blank";
    #       "startup.homepage_welcome_url.additional" = "";
    #       "toolkit.startup.max_resumed_crashes" = -1;
    #       "zen.workspaces.continue-where-left-off" = true;
    #       "zen.view.compact.hide-tabbar" = true;
    #       "zen.urlbar.behavior" = "float";
    #       "zen.welcome-screen.seen" = true;
    #     };
    #   };
    # };

    # librewolf = {
    #   enable = false;
    #   configPath = ".config/librewolf";
    #   package = pkgs.librewolf.override {
    #     extraPrefsFiles = [
    #       (builtins.fetchurl {
    #         url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
    #         sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
    #       })
    #     ];
    #   };
    #   profiles.default = {
    #     search = {
    #       default = "google";
    #       order = [
    #         "ddg"
    #         "google"
    #         "nix-packages"
    #         "nixos-wiki"
    #       ];
    #       engines = {
    #         nix-packages = {
    #           name = "Nix Packages";
    #           urls = [
    #             {
    #               template = "https://search.nixos.org/packages";
    #               params = [
    #                 {
    #                   name = "type";
    #                   value = "packages";
    #                 }
    #                 {
    #                   name = "query";
    #                   value = "{searchTerms}";
    #                 }
    #               ];
    #             }
    #           ];
    #
    #           icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    #           definedAliases = [ "@np" ];
    #         };
    #
    #         nixos-wiki = {
    #           name = "NixOS Wiki";
    #           urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
    #           iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
    #           definedAliases = [ "@nw" ];
    #         };
    #
    #         bing.metaData.hidden = true;
    #         google.metaData.alias = "@g";
    #         duckduckgo.metaData.alias = "@d";
    #       };
    #     };
    #   };
    # };

    #   floorp = {
    #     enable = false;
    #     configPath = ".config/floorp";
    #     package = pkgs.floorp-bin.override {
    #       extraPrefsFiles = [
    #         (builtins.fetchurl {
    #           url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
    #           sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
    #         })
    #       ];
    #     };
    #     profiles.default = {
    #       search = {
    #         default = "google";
    #         order = [
    #           "ddg"
    #           "google"
    #           "nix-packages"
    #           "nixos-wiki"
    #         ];
    #         engines = {
    #           nix-packages = {
    #             name = "Nix Packages";
    #             urls = [
    #               {
    #                 template = "https://search.nixos.org/packages";
    #                 params = [
    #                   {
    #                     name = "type";
    #                     value = "packages";
    #                   }
    #                   {
    #                     name = "query";
    #                     value = "{searchTerms}";
    #                   }
    #                 ];
    #               }
    #             ];
    #
    #             icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    #             definedAliases = [ "@np" ];
    #           };
    #
    #           nixos-wiki = {
    #             name = "NixOS Wiki";
    #             urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
    #             iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
    #             definedAliases = [ "@nw" ];
    #           };
    #
    #           bing.metaData.hidden = true;
    #           google.metaData.alias = "@g";
    #           duckduckgo.metaData.alias = "@d";
    #         };
    #       };
    #     };
    #   };
  };

  # home.packages = [ pkgs.atool pkgs.httpie ];
  # home.file.".config/yazi/init.lua".source = mkOutOfStoreSymlink "${config.xdg.configHome}/yazi/init.lua";

  # programs = {
  #   yazi = {
  #     enable = true;
  #     initLua = "~/.config/yazi/init.lua";
  #   };
  # };
}
