pkg_origin=cosmos
# $Id: PKGBUILD 64685 2010-01-21 21:49:23Z juergen $
# Maintainer: Juergen Hoetzel <juergen@archlinux.org>

pkg_name=rep-gtk
pkg_version=0.90.2
pkg_description="Binding of the GTK and GDK libraries for the librep Lisp environment"
pkg_upstream_url="http://rep-gtk.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('librep>=0.90.0' 'gtk2')
pkg_source=(http://downloads.sourceforge.net/sourceforge/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2)
pkg_shasum=('3477b19e9dc4eeb3255f3596e40d3e4c')

do_build() {
  ./configure --prefix=/usr || return 1
  make || return 1
  make DESTDIR="${CACHE_PATH}" install || return 1
}
