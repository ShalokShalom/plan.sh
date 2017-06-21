pkg_origin=cosmos

pkg_name=libxxf86dga
pkg_version=1.1.4
pkg_description="X11 Direct Graphics Access extension library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxext' 'xf86dgaproto')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXxf86dga-${pkg_version}.tar.bz2")
pkg_shasum=('d7dd9b9df336b7dd4028b6b56542ff2c')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -Dm644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING"
}
