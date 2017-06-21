pkg_origin=cosmos

pkg_name=libxxf86vm
pkg_version=1.1.4
pkg_description="X11 XFree86 video mode extension library"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('libxext' 'xf86vidmodeproto')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXxf86vm-${pkg_version}.tar.bz2")
pkg_shasum=('298b8fff82df17304dfdb5fe4066fe3a')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -d -m755 "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
