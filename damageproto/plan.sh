pkg_origin=cosmos

pkg_name=damageproto
pkg_version=1.2.1
pkg_description="X11 Damage extension wire protocol"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('xproto' 'fixesproto')
pkg_source=("http://xorg.freedesktop.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('998e5904764b82642cc63d97b4ba9e95')

do_build() {
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
