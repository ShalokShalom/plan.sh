pkg_origin=cosmos

pkg_name=libxinerama
pkg_version=1.1.3
pkg_description="X11 Xinerama extension library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxext' 'xineramaproto')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXinerama-${pkg_version}.tar.bz2")
pkg_shasum=('9336dc46ae3bf5f81c247f7131461efd')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install
  
  install -Dm644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING"
}
