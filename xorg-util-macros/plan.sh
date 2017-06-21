pkg_origin=cosmos

pkg_name=xorg-util-macros
pkg_version=1.19.1
pkg_description="X.Org Autotools macros"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_source=("http://ftp.x.org/pub/individual/util/util-macros-${pkg_version}.tar.bz2")
pkg_shasum=('6e76e546a4e580f15cebaf8019ef1625')

do_build() {

  ./configure --prefix=/usr 
  make
}

do_package() {

  make DESTDIR=${CACHE_PATH} install 
  install -m755 -d ${CACHE_PATH}/usr/lib

  mv ${CACHE_PATH}/usr/share/pkgconfig ${CACHE_PATH}/usr/lib/
  install -m755 -d ${CACHE_PATH}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
