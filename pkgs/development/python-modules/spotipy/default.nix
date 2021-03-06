{ stdenv, buildPythonPackage, fetchPypi, requests }:

buildPythonPackage rec {
  pname = "spotipy";
  version = "2.13.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "d1a85b8831ed60d2290ab9bbba289c548fb9680889757252c02dab2f2327d865";
  };

  propagatedBuildInputs = [ requests ];

  meta = with stdenv.lib; {
    homepage = "https://spotipy.readthedocs.org/";
    description = "A light weight Python library for the Spotify Web API";
    license = licenses.mit;
    maintainers = [ maintainers.rvolosatovs ];
  };
}
