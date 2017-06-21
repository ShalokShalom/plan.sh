pkg_origin=cosmos

pkg_name=fontcacheproto
pkg_version=0.1.3
pkg_description="X11 font cache extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('BSD')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('a8a50e5e995bfacb0359575faf7f6906')

do_build() {
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
