pkg_origin=cosmos

pkg_name=libxpm
pkg_version=3.5.12
pkg_description="X11 pixmap library"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('libxt' 'libxext')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXpm-${pkg_version}.tar.bz2")
pkg_shasum=('20f4627672edb2bd06a749f11aa97302')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
