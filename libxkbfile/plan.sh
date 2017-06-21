pkg_origin=cosmos

pkg_name=libxkbfile
pkg_version=1.0.9
pkg_description="X11 keyboard file manipulation library"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('libx11')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('4a4cfeaf24dab1b991903455d6d7d404')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static 
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
