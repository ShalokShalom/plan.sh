pkg_origin=cosmos

pkg_name=libstdc++5
pkg_version=3.3.6
pkg_description="GNU Standard C++ library version 3"
pkg_upstream_url="http://gcc.gnu.org"
pkg_license=('GPL' 'LGPL')
pkg_deps=('gcc-libs')
pkg_build_deps=('binutils' 'gcc')
pkg_source=("ftp://gcc.gnu.org/pub/gcc/releases/gcc-${pkg_version}/gcc-core-${pkg_version}.tar.bz2"
        "ftp://gcc.gnu.org/pub/gcc/releases/gcc-${pkg_version}/gcc-g++-${pkg_version}.tar.bz2"
        'gcc-3.4.3-no_multilib_amd64.patch')
pkg_shasum=('18c52e6fb8966b7700665dca289d077f'
         '6b3d00b8d079805be1b895f7f6ce47a0' 
         '088e0807e677010cafe4e590e8711be1')

do_build(){
  export CFLAGS="-march=${CARCH/_/-} -O2 -pipe"
  export CXXFLAGS="-march=${CARCH/_/-} -O2 -pipe"

  patch -p0 -i ${CACHE_PATH}/gcc-3.4.3-no_multilib_amd64.patch
  sed -i "s|O_CREAT|O_CREAT, 0666|" gcc/collect2.c

  # No fixincludes
  sed -i -e 's@\./fixinc\.sh@-c true@' gcc/Makefile.in
  mkdir ../gcc-build
  ../gcc-${pkg_version}/configure --prefix=/usr \
      --enable-shared \
      --enable-languages=c++ \
      --enable-threads=posix --enable-__cxa_atexit \
      --disable-multilib \
      --libdir=/usr/lib
  make all-target-libstdc++-v3 BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O"
}

do_package() {
  make DESTDIR=${pkg_prefix} install-target-libstdc++-v3 

  # Remove includefiles and libs provided by gcc
  rm -rf ${pkg_prefix}/usr/{include,share/locale}
  rm -f ${pkg_prefix}/usr/lib/*.a
  rm -f ${pkg_prefix}/usr/lib/libstdc++.so
}
