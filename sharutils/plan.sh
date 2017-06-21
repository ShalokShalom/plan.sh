pkg_origin=cosmos
# $Id: PKGBUILD 78003 2010-04-19 08:13:10Z dgriffiths $
# Maintainer: Kevin Piche <kevin@archlinux.org>
# Contributor: Tom Newsom <Jeepster@gmx.co.uk>

pkg_name=sharutils
pkg_version=4.11.1
pkg_description="GNU shar makes so-called shell archives out of many files"
pkg_upstream_url="http://www.gnu.org/software/sharutils/"
pkg_license=('GPL')
pkg_deps=('gettext' 'texinfo')
install=sharutils.install
pkg_source=(ftp://ftp.gnu.org/gnu/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2)
pkg_shasum=('52dd02b6f5e0a148ba871234ae29bba2')

do_build() {
  ./configure --prefix=/usr \
              --mandir=/usr/share/man \
              --infodir=/usr/share/info \
              --disable-nls
    make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
}
