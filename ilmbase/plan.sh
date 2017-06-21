pkg_origin=cosmos

pkg_name=ilmbase
pkg_version=2.2.0
pkg_description="IlmThread is a thread abstraction library for use with OpenEXR"
pkg_upstream_url="http://www.openexr.com"
pkg_license=('custom')
pkg_deps=('gcc-libs')
pkg_source=("http://download.savannah.nongnu.org/releases/openexr/$pkg_name-$pkg_version.tar.gz"
        'pkgconfig.patch'
        'undefined.patch')
pkg_shasum=('b540db502c5fa42078249f43d18a4652'
         'ed3eb3dfa2393adc6829cc9ca8caa0ff'
         '27ff3915e03964f85a9e9fb896a93479')

do_build() {
  patch -p1 -i  ${CACHE_PATH}/pkgconfig.patch
  patch -p1 -i  ${CACHE_PATH}/undefined.patch

  ./configure --prefix=/usr
   make PTHREAD_LIBS="-pthread -lpthread"
}

check() {

  make check || true
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  install -D -m644 COPYING $pkg_prefix/usr/share/licenses/$pkg_name/COPYING
}
