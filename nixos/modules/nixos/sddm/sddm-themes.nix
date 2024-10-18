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
      owner = "pkleineb";
      repo = "sddm-theme-corners";
      rev = "b94fb11";
      sha256 = "0i5x5cm2xn54f4qvla3dr3ih9qrkyrj8yagw6d9a5pb2d05jx0kb";
    };
  };
}
