{ buildPythonPackage
, isPy27
, asn1crypto
, azure-storage-blob
, boto3
, certifi
, cffi
, fetchPypi
, future
, idna
, ijson
, isPy3k
, lib
, oscrypto
, pyarrow
, pyasn1-modules
, pycryptodomex
, pyjwt
, pyopenssl
, pytz
, requests
, six
, urllib3
}:

buildPythonPackage rec {
  pname = "snowflake-connector-python";
  version = "2.2.10";
  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "0beba8eb9c1dec2782d52491d058256e1f5d9e010114a80ff3b8e3905be655fd";
  };

  propagatedBuildInputs = [
    azure-storage-blob
    asn1crypto
    boto3
    certifi
    cffi
    future
    idna
    ijson
    oscrypto
    pycryptodomex
    pyjwt
    pyopenssl
    pytz
    requests
    six
  ] ++ lib.optionals (!isPy3k) [
    pyarrow
    pyasn1-modules
    urllib3
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace "'cffi>=1.9,<1.14'," "'cffi~=1.9',"
  '';

  # tests are not working
  # XXX: fix the tests
  doCheck = false;

  meta = with lib; {
    description = "Snowflake Connector for Python";
    homepage = "https://www.snowflake.com/";
    license = licenses.asl20;
  };
}
