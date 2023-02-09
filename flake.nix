{
  description = "Proof-of-concept using composefs to ensure integrity of a NixOS system";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    nixosConfigurations.vm = pkgs.nixos ./configuration.nix;

    packages.x86_64-linux = {
      composefs = pkgs.callPackage ./composefs {};
    };
  };
}
