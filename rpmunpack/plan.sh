pkg_origin=cosmos
# $Id: PKGBUILD 78013 2010-04-19 08:17:50Z dgriffiths $
# Maintainer: dale <dale@archlinux.org>
# Contributor: Tom Newsom <Jeepster@gmx.co.uk>

pkg_name=rpmunpack
pkg_version=0
pkg_description="This program converts rpm archives to cpio archives for cpio or afio"
pkg_upstream_url="http://www.ibiblio.org/pub/Linux/utils/package"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_source=(http://www.ibiblio.org/pub/Linux/utils/package/${pkg_name}.tar.gz LICENSE)
pkg_shasum=('59608ae17af86e39e867329448674674' '93877a588c62512621c6d155bf6679a0')

do_build() {
  make || return 1
  install -D -m755 rpmunpack ${CACHE_PATH}/usr/bin/rpmunpack || return 1
  install -D -m644 ../LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
