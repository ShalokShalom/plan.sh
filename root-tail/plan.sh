pkg_origin=cosmos
# $Id: PKGBUILD 78018 2010-04-19 08:18:58Z dgriffiths $
# Contributor:  John Sowiak <john@archlinux.org>

pkg_name=root-tail
pkg_version=1.2
pkg_description="Displays logfiles in different colours on your root-window"
pkg_upstream_url="http://www.goof.com/pcg/marc/root-tail.html"
pkg_license=('GPL')
pkg_deps=('libxext')
pkg_build_deps=('imake')
pkg_source=(http://www.goof.com/pcg/marc/data/${pkg_name}-${pkg_version}.tar.gz)
pkg_shasum=('5a4b3c4c7ab3bed1f4575e9688aac5de')

do_build() {
  xmkmf -a || return 1
  make || return 1
  make DESTDIR=${CACHE_PATH} MANPATH=/usr/share/man install install.man || return 1
}
# vim: ts=2 sw=2 et ft=sh
