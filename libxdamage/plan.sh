pkg_origin=cosmos

pkg_name=libxdamage
pkg_version=1.1.4
pkg_description="X11 damaged region extension library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxfixes' 'damageproto')
pkg_build_deps=('pkg-config')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXdamage-${pkg_version}.tar.bz2")
pkg_shasum=('0cf292de2a9fa2e9a939aefde68fd34f')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static 
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
