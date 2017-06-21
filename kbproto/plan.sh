pkg_origin=cosmos

pkg_name=kbproto
pkg_version=1.0.7
pkg_description="X11 XKB extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('94afc90c1f7bef4a27fdd59ece39c878')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
  install -Dm644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING"
}
