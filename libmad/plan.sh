pkg_origin=cosmos

pkg_name=libmad
pkg_version=0.15.1b
pkg_description="A high-quality MPEG audio decoder"
pkg_upstream_url="http://www.underbit.com/products/mad/"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_build_deps=('autoconf')
pkg_source=("http://downloads.sourceforge.net/sourceforge/mad/${pkg_name}-${pkg_version}.tar.gz"
        'libmad.patch'
        'amd64-64bit.diff' 
        'frame_length.diff' 
        'optimize.diff')
pkg_shasum=('1be543bc30c56fb6bea1d7bf6a64e66c'
         'fbcca0267a423bae45389666f4cb04d5'
         '8d8bd64a2842dd59153b3a6642059e23'
         '3329b032118a68e18908197e65b3198d'
         '3e52afe2103f367810a18bef9e82eb9f')
         
do_build() {
  patch -p1 -i ${CACHE_PATH}/libmad.patch
  patch -p1 -i ${CACHE_PATH}/amd64-64bit.diff
  patch -p1 -i ${CACHE_PATH}/frame_length.diff 
  patch -p1 -i ${CACHE_PATH}/optimize.diff
  
  CFLAGS="$CFLAGS -ftree-vectorize -ftree-vectorizer-verbose=1"
  autoconf
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
