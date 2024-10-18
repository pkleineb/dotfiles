{ stdenv, fetchFromGitHub }:

{
  corners = stdenv.mkDerivation rec {
    pname = "sddm-corners-theme";
    version = "1.0";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/corners
    '';

    src = fetchFromGitHub {
      owner = "aczw";
      repo = "sddm-theme-corners";
      rev = "6ff0ff4";
      sha256 = "0iiasrbl7ciyhq3z02la636as915zk9ph063ac7vm5iwny8vgwh8";
    };
  };
}
