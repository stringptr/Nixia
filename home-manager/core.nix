{
  home-manager,
  ...
}:

{
  imports = [
    ./desktop.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
