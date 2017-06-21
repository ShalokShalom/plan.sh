pkg_origin=cosmos

pkg_name=libxres
pkg_version=1.0.7
pkg_description='X11 Resource extension library'
pkg_upstream_url="http://xorg.freedesktop.org"
pkg_license=('custom')
pkg_deps=('libxext')
pkg_build_deps=('resourceproto' 'damageproto' 'compositeproto' 'scrnsaverproto' 'xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXres-${pkg_version}.tar.bz2")
pkg_shasum=('45ef29206a6b58254c81bea28ec6c95f')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
}
