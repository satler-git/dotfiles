# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
  dockerTools,
}:
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
  testing-language-server = {
    pname = "testing-language-server";
    version = "48af0e012ceda9440d3b5e15bb23403cc2c20ec5";
    src = fetchFromGitHub {
      owner = "kbwo";
      repo = "testing-language-server";
      rev = "48af0e012ceda9440d3b5e15bb23403cc2c20ec5";
      fetchSubmodules = false;
      sha256 = "sha256-udifieFnGIVqXwCL8EwcYrwh9JxKkhweg18pXdXAqoY=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./testing-language-server-48af0e012ceda9440d3b5e15bb23403cc2c20ec5/Cargo.lock;
      outputHashes = {

      };
    };
    date = "2025-01-04";
  };
  yazi-plugins = {
    pname = "yazi-plugins";
    version = "600614a9dc59a12a63721738498c5541c7923873";
    src = fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "600614a9dc59a12a63721738498c5541c7923873";
      fetchSubmodules = false;
      sha256 = "sha256-mQkivPt9tOXom78jgvSwveF/8SD8M2XCXxGY8oijl+o=";
    };
    date = "2025-01-02";
  };
}
