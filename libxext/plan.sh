pkg_origin=cosmos
pkg_name=libxext
pkg_version=1.3.3
pkg_description="X11 miscellaneous extensions library"
pkg_upstream_url=('http://xorg.freedesktop.org/')
pkg_license=('custom')
pkg_deps=('cosmos/libx11' 'xorg/xextproto')
pkg_build_deps=('core/pkg-config')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXext-${pkg_version}.tar.bz2")

build() {
  cd "${CACHE_PATH}/libXext-${pkg_version}"
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

package() {
  cd "${CACHE_PATH}/libXext-${pkg_version}"
  make DESTDIR="${pkg_prefix}" install

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
