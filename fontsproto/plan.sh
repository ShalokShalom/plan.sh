pkg_origin=cosmos

pkg_name=fontsproto
pkg_version=2.1.3
pkg_description="X11 font extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_build_deps=('xorg-util-macros')
pkg_source=(${url}/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2)
pkg_shasum=('36934d00b00555eaacde9f091f392f97')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -Dm644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING"
}
