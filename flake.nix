{
  description = "OSX Bootstrap flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {pkgs, ...}: {
        devShells.default = pkgs.mkShell {
          name = "OSX";
          packages = with pkgs; [
            dmg2img
            qemu_full
            cmake
            tesseract
            nettools
            screen
            virt-manager
            python3
          ];
        };
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "OSX";
          version = builtins.substring 0 8 self.rev or "dirty";

          src = pkgs.lib.cleanSource ./.;

          nativeBuildInputs = with pkgs; [
            dmg2img
            qemu-utils
            cmake
            tesseract
            nettools
            python3
          ];

          buildPhase = ''
          '';

          installPhase = ''
          '';
        };
      };
    };
}
