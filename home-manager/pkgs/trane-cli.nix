{ pkgs, fetchFromGitHub, ... }:
let
  trane-cli = pkgs.rustPlatform.buildRustPackage {
          pname = "trane-cli";
          version = "0.22.0";

          buildInputs = [ pkgs.openssl ];
          nativeBuildInputs = [ pkgs.pkg-config ];


          src = pkgs.fetchFromGitHub {
            owner = "trane-project";
            repo = "trane-cli";
            rev = "d2e456a791898381c890ffcbb92a92642614cf0d";
            sha256 = "sha256-UDYY52PBvlnfXL+XnmdiTtjIf1sgnZvUwabtTy8QYbc=";
          };

          cargoHash = "sha256-/3gJuAWM/6NmCOwj0tmdl9fcUoPO14H5+pOZkQgHbBM=";
        };
in{
  home.packages = [
    trane-cli
  ];
}
