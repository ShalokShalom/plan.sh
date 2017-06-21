pkg_origin=cosmos

pkg_name=bigreqsproto
pkg_version=1.1.2
pkg_description="X11 Big Requests extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_build_deps=('xorg-util-macros' 'xmlto' 'docbook-xml')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('1a05fb01fa1d5198894c931cf925c025')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/ 
}

