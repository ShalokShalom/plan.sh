pkg_origin=cosmos

pkg_name=libice
pkg_version=1.0.9
pkg_description="X11 Inter-Client Exchange library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('glibc' 'xproto')
pkg_build_deps=('pkgconfig' 'xtrans')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libICE-${pkg_version}.tar.bz2")
pkg_license=('custom')
pkg_shasum=('addfb1e897ca8079531669c7c7711726')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install
  
  install -Dm644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING"
}
