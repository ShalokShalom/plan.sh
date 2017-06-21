pkg_origin=cosmos
pkg_name=libxmu
pkg_version=1.1.2
pkg_description="X11 miscellaneous micro-utility library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('cosmos/libxext' 'libxt')
pkg_build_deps=('xorg-util-macros')
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXmu-${pkg_version}.tar.bz2")

do_build() {
  cd libXmu-${pkg_version}
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

do_package() {
  cd libXmu-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/

}
