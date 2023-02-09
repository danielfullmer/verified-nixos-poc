{ stdenv, fetchFromGitHub, autoreconfHook, pkg-config, fsverity-utils, openssl }:

stdenv.mkDerivation {
  pname = "composefs";
  version = "unstable-2023-01-31";

  src = fetchFromGitHub (import ./src.nix);

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [ fsverity-utils openssl ];
}
