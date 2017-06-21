pkg_origin=cosmos
#
pkg_name=libpciaccess
pkg_version=0.13.5
pkg_description="X11 PCI access library"
pkg_license=('custom')
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_deps=('glibc')
pkg_build_deps=('pkgconfig' 'xorg-util-macros')
pkg_source=("https://xorg.freedesktop.org//releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('d810ab17e24c1418dedf7207fb2841d4')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
