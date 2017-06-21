pkg_origin=cosmos
# $Id: PKGBUILD 84000 2010-06-25 09:22:24Z tpowa $
# Maintainer: Tobias Powalowski <tpowa@archlinux.org>

pkg_name=pmount
pkg_version=0.9.23
pkg_description="mount removable devices as normal user"
pkg_license=('GPL2')
pkg_upstream_url="http://pmount.alioth.debian.org/"
backup=('etc/pmount.allow')
pkg_deps=('sysfsutils>=2.0.0-1' 'bash')
pkg_deps=('hal: needed for pmount-hal')
pkg_build_deps=('intltool' 'hal')
pkg_source=(https://alioth.debian.org/frs/download.php/3310/pmount-0.9.23.tar.bz2)

do_build() {
  ./configure --prefix=/usr --with-cryptsetup-prog=/sbin/cryptsetup || return 1
  make || return 1 
  make DESTDIR="${pkg_prefix}" install || return 1
}
pkg_shasum=('db19f5bf3151b1b41705ec7bafa439d3')
