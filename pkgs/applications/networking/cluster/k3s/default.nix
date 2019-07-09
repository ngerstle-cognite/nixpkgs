{ stdenv, fetchFromGitHub, dapper, docker }:
let
  version = "0.6.1";
in
stdenv.mkDerivation {
  name = "k3s-${version}";

  src = fetchFromGitHub {
    owner  = "rancher";
    repo   = "k3s";
    rev    = "v${version}";
    sha256 = "0f7j87zas2snn3273wm6yxn9spwl77a21bslawh1vgsc2mn7sf1r";
  };


  buildInputs = [ docker dapper ];

  buildPhase = ''
    dapper ./scripts/ci
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv dist/artifacts/k3s $out/bin/k3s
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/rancher/k3s";
    description = "Lightweight Kubernetes";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with maintainers; [kuznero];
  };
}
