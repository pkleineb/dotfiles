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
      sha256 = "0cf0q28c7cg36fabjpxf1lqp9snz1ndf2h8935d9q3ky1lg3c4zb";
    };
  };
}
