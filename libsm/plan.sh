pkg_origin=cosmos

pkg_name=libsm
pkg_version=1.2.2
pkg_description="X11 Session Management library"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('libice' 'util-linux')
pkg_build_deps=('xorg-util-macros' 'xtrans')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libSM-${pkg_version}.tar.bz2")
pkg_shasum=('499a7773c65aba513609fe651853c5f3')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -d -m755 "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
