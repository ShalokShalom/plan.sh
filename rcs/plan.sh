pkg_origin=cosmos
# $Id: PKGBUILD 78028 2010-04-19 08:23:42Z dgriffiths $
# Maintainer: dorphell <dorphell@archlinux.org>
pkg_name=rcs
pkg_version=5.7
pkg_description="Revision Control System"
pkg_upstream_url="http://www.cs.purdue.edu/homes/trinkle/RCS/"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=(http://www.cs.purdue.edu/homes/trinkle/RCS/rcs-${pkg_version}.tar.Z \
        rcs-5.7.patch)
pkg_shasum=('423282f0edb353296d9f3498ab683abf' '7ae4b7cb79259ccdf5eee0ab94fe2a2a')

do_build() {
  patch -Np1 -i ../rcs-5.7.patch || return 1
  ./configure --prefix=/usr || return 1
  make || return 1
  make prefix=${CACHE_PATH}/usr man1dir=${CACHE_PATH}/usr/share/man/man1 \
    man5dir=${CACHE_PATH}/usr/share/man/man5 install || return 1
}
