pkg_origin=cosmos

pkg_name=libdmx
pkg_version=1.1.3
pkg_description="X11 Distributed Multihead extension library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('dmxproto' 'libxext')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('ba983eba5a9f05d152a0725b8e863151')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
