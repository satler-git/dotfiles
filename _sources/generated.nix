# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
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
  yazi-compress = {
    pname = "yazi-compress";
    version = "60b24af23d1050f1700953a367dd4a2990ee51aa";
    src = fetchFromGitHub {
      owner = "KKV9";
      repo = "compress.yazi";
      rev = "60b24af23d1050f1700953a367dd4a2990ee51aa";
      fetchSubmodules = false;
      sha256 = "sha256-Yf5R3H8t6cJBMan8FSpK3BDSG5UnGlypKSMOi0ZFqzE=";
    };
    date = "2024-08-10";
  };
  yazi-plugins = {
    pname = "yazi-plugins";
    version = "8ed253716c60f3279518ce34c74ca053530039d8";
    src = fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "8ed253716c60f3279518ce34c74ca053530039d8";
      fetchSubmodules = false;
      sha256 = "sha256-xY2yVCLLcXRyFfnmyP6h5Fw+4kwOZhEOCWVZrRwXnTA=";
    };
    date = "2025-01-24";
  };
}
