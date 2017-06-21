pkg_origin=cosmos

pkg_name=libxrender
pkg_version=0.9.10
pkg_description="X Rendering Extension client library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libx11' 'renderproto')
pkg_build_deps=('pkgconfig')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXrender-${pkg_version}.tar.bz2")
pkg_shasum=('802179a76bded0b658f4e9ec5e1830a4')

do_build() {
  
  ./configure --prefix=/usr \
              --disable-static 
  make 
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
