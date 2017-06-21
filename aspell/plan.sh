pkg_origin=cosmos

pkg_name=aspell
pkg_version=0.60.6.1
_pkgmajorver=0.60
pkg_description="A spell checker designed to eventually replace Ispell"
pkg_upstream_url="http://aspell.net/"
pkg_license=('LGPL')
pkg_deps=('gcc-libs' 'ncurses')
pkg_deps=('perl: to import old dictionaries')
pkg_source=("ftp://ftp.gnu.org/gnu/aspell/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('e66a9c9af6a60dc46134fdacf6ce97d7')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install
  
  ln -s ${pkg_name}-${_pkgmajorver} "${pkg_prefix}/usr/lib/${pkg_name}"
}
