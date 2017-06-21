pkg_origin=cosmos

pkg_name=libxau
pkg_version=1.0.8
pkg_description="X11 authorisation library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('glibc')
pkg_build_deps=('pkgconfig' 'xproto')
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXau-${pkg_version}.tar.bz2")
pkg_shasum=('685f8abbffa6d145c0f930f00703b21b')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

package () {
  
  make DESTDIR="${pkg_prefix}" install
  install -Dm644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING"
}
