pkg_origin=cosmos

pkg_name=libxaw
pkg_version=1.0.13
pkg_description="X11 Athena Widget library"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('libxmu' 'libxpm')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXaw-${pkg_version}.tar.bz2")
pkg_shasum=('e5e06eb14a608b58746bdd1c0bd7b8e3')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install
  
  install -Dm644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING"
}
