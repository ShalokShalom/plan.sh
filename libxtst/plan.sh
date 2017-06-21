pkg_origin=cosmos

pkg_name=libxtst
pkg_version=1.2.3
pkg_description="X11 Testing -- Resource extension library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxext' 'libxi' 'recordproto' 'inputproto')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXtst-${pkg_version}.tar.bz2")
pkg_shasum=('ef8c2c1d16a00bd95b9fdcef63b8a2ca')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
