pkg_origin=cosmos

pkg_name=python2-crypto
_pkg_name=pycrypto
pkg_version=2.6
pkg_description="A collection of cryptographic algorithms and protocols, implemented for use from Python."
pkg_deps=('python2')
pkg_upstream_url="http://www.dlitz.net/software/pycrypto/"
pkg_license=(custom)
pkg_source=(http://ftp.dlitz.net/pub/dlitz/crypto/${_pkg_name}/${_pkg_name}-${pkg_version}.tar.gz)
sha256sums=('7293c9d7e8af2e44a82f86eb9c3b058880f4bcc884bf3ad6c8a34b64986edde8')

do_build() {
  python2 setup.py build
  python2 setup.py install --root="${CACHE_PATH}" --optimize=1
  install -m755 -d "${CACHE_PATH}/usr/share/licenses/${pkg_name}"
  install -m644 COPYRIGHT "${CACHE_PATH}/usr/share/licenses/${pkg_name}/"
  cp -r LEGAL "${CACHE_PATH}/usr/share/licenses/${pkg_name}/"
}
