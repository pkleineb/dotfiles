{ stdenv, fetchFromGitHub, pkgs }:

{
  corners = stdenv.mkDerivation rec {
    pname = "sddm-corners-theme";
    version = "1.0";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src/corners $out/share/sddm/themes/corners
    '';

    src = fetchFromGitHub {
      owner = "pkleineb";
      repo = "sddm-theme-corners";
      rev = "93424cd";
      sha256 = "0vnhr8p7b0qi58wmzqq31kf7pkarjdcghkic394x9jvivirfvic7";
    };
  };
}
