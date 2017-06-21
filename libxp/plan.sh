pkg_origin=cosmos

pkg_name=libxp
pkg_version=1.0.3
pkg_description="X11 X Print Library"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('libxext' 'printproto')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXp-${pkg_version}.tar.bz2")
pkg_license=('custom')
pkg_shasum=('df9e6bf0d988de6694f08693b8002079')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install
  
  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
