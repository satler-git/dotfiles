# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  yazi-compress = {
    pname = "yazi-compress";
    version = "9fc8fe0bd82e564f50eb98b95941118e7f681dc8";
    src = fetchFromGitHub {
      owner = "KKV9";
      repo = "compress.yazi";
      rev = "9fc8fe0bd82e564f50eb98b95941118e7f681dc8";
      fetchSubmodules = false;
      sha256 = "sha256-VKo4HmNp5LzOlOr+SwUXGx3WsLRUVTxE7RI7kIRKoVs=";
    };
    date = "2025-06-02";
  };
  yazi-plugins = {
    pname = "yazi-plugins";
    version = "b8860253fc44e500edeb7a09db648a829084facd";
    src = fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "b8860253fc44e500edeb7a09db648a829084facd";
      fetchSubmodules = false;
      sha256 = "sha256-29K8PmBoqAMcQhDIfOVnbJt2FU4BR6k23Es9CqyEloo=";
    };
    date = "2025-07-06";
  };
}
