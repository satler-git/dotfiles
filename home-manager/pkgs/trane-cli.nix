{ pkgs, fetchFromGitHub, ... }:
let
  trane-cli-src = (pkgs.callPackages ../../_sources/generated.nix {}).trane-cli;

  trane-cli = pkgs.rustPlatform.buildRustPackage {
    pname = "trane-cli";
    version = "0.22.0";

    buildInputs = [ pkgs.openssl ];
    nativeBuildInputs = [ pkgs.pkg-config ];

    src = trane-cli-src.src;
    cargoLock.lockFile = trane-cli-src.cargoLock."Cargo.lock".lockFile;
  };
in
{
  home.packages = [
    trane-cli
  ];
}
