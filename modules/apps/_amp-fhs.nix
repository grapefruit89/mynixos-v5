# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-APP-AMP-FHS-001",
#   "title": "AMP FHS Sandbox",
#   "layer": 60,
#   "category": "apps/gaming",
#   "description": "FHS Sandbox for AMP Game Server Panel (Native / Docker-free)."
# }
# ---ENDNIXMETA

{ pkgs, ... }:

pkgs.buildFHSEnv {
  name = "amp-fhs";
  targetPkgs = pkgs: with pkgs; [
    dotnet-sdk_8
    glibc
    glibc.dev
    stdenv.cc.cc.lib # libstdc++
    openssl
    curl
    libicu
    sqlite
    screen
    bash
    coreutils
    procps
    findutils
    steamcmd
    icu
    zlib
    krb5
  ];
  multiPkgs = pkgs: with pkgs; [
    pkgsi686Linux.glibc
  ];
  runScript = "bash";
}
