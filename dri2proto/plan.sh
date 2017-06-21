pkg_origin=cosmos

pkg_name=dri2proto
pkg_version=2.8
pkg_description="X11 DRI protocol"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('b2721d5d24c04d9980a0c6540cb5396a')

do_build() {
  
  ./configure --prefix=/usr 
  make 
}

do_package() {
  make DESTDIR="${pkg_prefix}" install 

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/" 
}

