pkg_origin=cosmos

pkg_name=libsidplay
pkg_version=1.36.59
pkg_description="A library for playing SID music files."
pkg_upstream_url="http://critical.ch/distfiles/"
pkg_license=('GPL')
pkg_deps=('gcc-libs')
pkg_source=("http://critical.ch/distfiles/${pkg_name}-${pkg_version}.tgz"
        'libsidplay-1.36.59-gcc43.patch')
pkg_shasum=('37c51ba4bd57164b1b0bb7b43b9adece'
         'c24d7bca2639f4fee03c40c7dcaadfee')

do_build() {
  patch -p1 -i ${CACHE_PATH}/libsidplay-1.36.59-gcc43.patch
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
