pkg_origin=cosmos

pkg_name=xorg-fonts-encodings
pkg_version=1.0.4
pkg_description="X.org font encoding files"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('xorg-font-utils')
pkg_source=("https://xorg.freedesktop.org/releases/individual/font/encodings-${pkg_version}.tar.bz2")
pkg_shasum=('0f2d6546d514c5cc4ecf78a60657a5c1')

do_build() {
  
  ./configure --prefix=/usr --with-encodingsdir=/usr/share/fonts/encodings
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING
}
