pkg_origin=cosmos

pkg_name=inputproto
pkg_version=2.3.2
pkg_description="X11 Input extension wire protocol"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_build_deps=('xorg-util-macros' 'asciidoc')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('b290a463af7def483e6e190de460f31a')

do_build() {
  
  ./configure --prefix=/usr 
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install 

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/ 
}
