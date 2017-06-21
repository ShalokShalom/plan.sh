pkg_origin=cosmos

pkg_name=libxdmcp
pkg_version=1.1.2
pkg_description="X11 Display Manager Control Protocol library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('xproto' 'glibc')
pkg_build_deps=('pkgconfig')
pkg_source=("http://xorg.freedesktop.org//releases/individual/lib/libXdmcp-${pkg_version}.tar.bz2")
pkg_shasum=('18aa5c1279b01f9d18e3299969665b2e')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

package () {
  make DESTDIR="${pkg_prefix}" install

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
