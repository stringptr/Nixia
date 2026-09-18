{
  description = "Nixia";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    augustfirmware.url = "github:NixOS/nixpkgs/3043fb8cf49616fc4142a2da0343e85408918d60";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    # yazi.url = "github:sxyazi/yazi";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snitch.url = "github:karol-broda/snitch";

    iasevka.url = "github:stringptr/iasevka";

    prismlauncher = {
      url = "github:stringptr/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS/development";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      augustfirmware,
      home-manager,
      nix-alien,
      nix-index-database,
      quickshell,
      iasevka,
      prismlauncher,
      jovian,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      augustfirmwarePkgs = augustfirmware.legacyPackages.${system};

      spicetify = inputs.spicetify-nix.lib.${system}.mkSpicetify pkgs { };
    in
    {
      nixosConfigurations.Nixia = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          (_: {
            nixpkgs.overlays = [
              (final: prev: {
                linux-firmware = augustfirmwarePkgs.linux-firmware;
              })
            ];
          })

          ./configuration.nix
          nix-index-database.nixosModules.default
          home-manager.nixosModules.default
        ];
      };
    };
}
