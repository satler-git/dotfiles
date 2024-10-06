# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  harper-ls = {
    pname = "harper-ls";
    version = "c4a3a0c3136e6903dce5a5af350daac51af00a01";
    src = fetchFromGitHub {
      owner = "elijah-potter";
      repo = "harper";
      rev = "c4a3a0c3136e6903dce5a5af350daac51af00a01";
      fetchSubmodules = false;
      sha256 = "sha256-dTp+ZVA6YZ1lbZuXb81dbvBoiYMmEpiYARgBwlO+JM4=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./harper-ls-c4a3a0c3136e6903dce5a5af350daac51af00a01/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-10-06";
  };
  trane-cli = {
    pname = "trane-cli";
    version = "d2e456a791898381c890ffcbb92a92642614cf0d";
    src = fetchFromGitHub {
      owner = "trane-project";
      repo = "trane-cli";
      rev = "d2e456a791898381c890ffcbb92a92642614cf0d";
      fetchSubmodules = false;
      sha256 = "sha256-UDYY52PBvlnfXL+XnmdiTtjIf1sgnZvUwabtTy8QYbc=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./trane-cli-d2e456a791898381c890ffcbb92a92642614cf0d/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-08-10";
  };
  zellij-room = {
    pname = "zellij-room";
    version = "v1.1.1";
    src = fetchurl {
      url = "https://github.com/rvcas/room/releases/download/v1.1.1/room.wasm";
      sha256 = "sha256-wCGnvFaoaoyH6QFkIqaDj0j0lGe1DOAX4ZmUQOyT/eY=";
    };
  };
  zellij-zj-quit = {
    pname = "zellij-zj-quit";
    version = "0.3.0";
    src = fetchurl {
      url = "https://github.com/cristiand391/zj-quit/releases/download/0.3.0/zj-quit.wasm";
      sha256 = "sha256-f1D3cDuLRZ5IqY3IGq6UYSEu1VK54TwmkmwWaxVQD2A=";
    };
  };
}
