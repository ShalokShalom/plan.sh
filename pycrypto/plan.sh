pkg_origin=cosmos
# $Id: PKGBUILD 72744 2010-03-19 11:35:50Z allan $
# Maintainer: Jan de Groot <jgc@archlinux.org>
# Contributor: Kritoke <kritoke@gamebox.net>

pkg_name=pycrypto
pkg_version=2.3
pkg_description="A collection of cryptographic algorithms and protocols, implemented for use from Python."
pkg_deps=('python2')
pkg_upstream_url="http://www.dlitz.net/software/pycrypto/"
pkg_license=(custom)
pkg_source=(http://ftp.dlitz.net/pub/dlitz/crypto/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz)
sha256sums=('4f11e85fbcf13960373650fc2dae8f088f9b001f07fb6d3efb2fcb5334987182')

do_build() {
  python2 setup.py build
  python2 setup.py install --root="${CACHE_PATH}" --optimize=1
  install -m755 -d "${CACHE_PATH}/usr/share/licenses/${pkg_name}"
  install -m644 COPYRIGHT "${CACHE_PATH}/usr/share/licenses/${pkg_name}/"
  cp -r LEGAL "${CACHE_PATH}/usr/share/licenses/${pkg_name}/"
}
