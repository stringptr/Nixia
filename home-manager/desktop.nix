{ config, inputs, pkgs, home-manager, ... }:

let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  # home.file.".config/yazi/init.lua".source = mkOutOfStoreSymlink "${config.xdg.configHome}/yazi/init.lua";
  home-manager.users.ia = {
    # programs = {
    #   yazi = {
    #     enable = true;
    #     initLua = "~/.config/yazi/init.lua";
    #   };
    # };
  };
}
