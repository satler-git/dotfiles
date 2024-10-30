# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  cargo-compete = {
    pname = "cargo-compete";
    version = "6d675a03e1373e5dd14dfdcb7cf8c40bb0bdb56c";
    src = fetchFromGitHub {
      owner = "qryxip";
      repo = "cargo-compete";
      rev = "6d675a03e1373e5dd14dfdcb7cf8c40bb0bdb56c";
      fetchSubmodules = false;
      sha256 = "sha256-qlRVHSUVOqdTx4H3pE19Fy634742veTisHm6IqfKBUQ=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./cargo-compete-6d675a03e1373e5dd14dfdcb7cf8c40bb0bdb56c/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-06-08";
  };
  harper-ls = {
    pname = "harper-ls";
    version = "1ee5fb64509e5483370375b456ec3bd90e71ca92";
    src = fetchFromGitHub {
      owner = "elijah-potter";
      repo = "harper";
      rev = "1ee5fb64509e5483370375b456ec3bd90e71ca92";
      fetchSubmodules = false;
      sha256 = "sha256-HJceyUBj2lxqV6rw7fOHo9xxpLgvmn8+Wh2CaQQ3j8k=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./harper-ls-1ee5fb64509e5483370375b456ec3bd90e71ca92/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-10-30";
  };
  testing-language-server = {
    pname = "testing-language-server";
    version = "92dec010a852c289aafba606eb48c1cc5c3d4eac";
    src = fetchFromGitHub {
      owner = "kbwo";
      repo = "testing-language-server";
      rev = "92dec010a852c289aafba606eb48c1cc5c3d4eac";
      fetchSubmodules = false;
      sha256 = "sha256-ZsUJEZ7D3nRzzu0PGqtDQck3g7Xywxf9tl3En2q6IfE=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./testing-language-server-92dec010a852c289aafba606eb48c1cc5c3d4eac/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-10-30";
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
