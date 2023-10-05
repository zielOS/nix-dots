{ stdenv
, lib
, fetchurl
, makeWrapper
, dpkg
, libxcb
, libGL
, nss
, libthai
, wayland
, alsa-lib
, autoPatchelfHook
, self
}:

stdenv.mkDerivation rec {
  pname = "insync-deb";
  version = "3.8.5.50499";

  src = fetchurl {
    url = " https://cdn.insynchq.com/builds/linux/insync_3.8.5.50499-lunar_amd64.deb";
    sha256 = "1dirv32z2wvi2143dghdj23mwlvxn5mi2j54mr7fz660q9xhk4ws";
  };

  postPatch = ''
    substituteInPlace usr/bin/insync --replace /usr/lib/insync $out/usr/lib/insync
  '';

  buildInputs = [
    alsa-lib
    libGL
    libthai
    libxcb
    nss
    wayland
  ];

  nativeBuildInputs = [ autoPatchelfHook dpkg makeWrapper ];

  unpackPhase = ''
    dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner
  '';

  installPhase = ''
    mkdir -p $out/bin $out/lib $out/share
    cp -R usr/* $out/
    rm $out/lib/insync/libGLX.so.0
    rm $out/lib/insync/libQt5*
    sed -i 's|/usr/lib/insync|/lib/insync|' "$out/bin/insync"
    wrapQtApp "$out/lib/insync/insync"
  '';

  dontConfigure = true;
  dontBuild = true;

  meta = with lib; {
    platforms = ["x86_64-linux"];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with maintainers; [ benley ];
    homepage = "https://www.insynchq.com";
    description = "Google Drive sync and backup with multiple account support";
    longDescription = ''
     Insync is a commercial application that syncs your Drive files to your
     computer.  It has more advanced features than Google's official client
     such as multiple account support, Google Doc conversion, symlink support,
     and built in sharing.
     There is a 15-day free trial, and it is a paid application after that.
    '';
    # download URL removed
    broken = false;
  };
}
