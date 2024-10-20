{ pkgs, fetchFromGitHub, ... }:
let
  cargo-compete-src = (pkgs.callPackages ../../_sources/generated.nix { }).cargo-compete;

  cargo-compete = pkgs.rustPlatform.buildRustPackage {
    pname = "cargo-compete";
    version = "0.10.7";

    buildInputs = [ pkgs.openssl ];
    nativeBuildInputs = [ pkgs.pkg-config ];

    src = cargo-compete-src.src;
    cargoLock.lockFile = cargo-compete-src.cargoLock."Cargo.lock".lockFile;

    doCheck = false; # tests in cargo-compete require network access
  };
in
{
  home.packages = [
    cargo-compete
  ];
}
