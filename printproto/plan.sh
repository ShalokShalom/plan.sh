pkg_origin=cosmos

pkg_name=printproto
pkg_version=1.0.5
pkg_description="X11 print extension wire protocol"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('99d0e25feea2fead7d8325b7000b41c3')

do_build() {
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install 

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/" 
}
