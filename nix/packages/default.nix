{ beam27Packages, elixir_1_18 }:
let
  beamPackages = beam27Packages.extend (self: super: { elixir = elixir_1_18; });
in beamPackages.mixRelease rec {
  pname = "plex-exporter";
  version = "0.0.1";
  src = ../../.;
  mixEnv = "prod";

  mixFodDeps = beamPackages.fetchMixDeps {
    inherit pname version src mixEnv;
    hash = "sha256-dJUokAlVD1z2LDS1L+xia+bsp5ADv3po9pAcSGxcQiM=";
  };

  removeCookie = false;

  meta.mainProgram = "plex_exporter";
}
