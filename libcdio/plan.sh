pkg_origin=cosmos

pkg_name=libcdio
pkg_version=0.94
pkg_description="GNU Compact Disc Input and Control Library"
pkg_license=('GPL3')
pkg_upstream_url="http://www.gnu.org/software/libcdio/"
pkg_deps=('gcc-libs' 'libcddb' 'ncurses')
pkg_source=("http://ftp.gnu.org/gnu/libcdio/${pkg_name}-${pkg_version}.tar.gz"
        'libcdio-0.83-linking.patch')
pkg_shasum=('d8734266a20fbc2605a97b701b838ab6'
         '2826f89c78f09b0c0cbaeb47d507a55e')

do_build() {
  
  patch -p1 -i ${CACHE_PATH}/libcdio-0.83-linking.patch
  
  ./configure --prefix=/usr \
              --disable-vcd-info \
              --enable-cpp-progs \
              --disable-static
              
  make
}

do_package() {
  make -j1 DESTDIR=${pkg_prefix} install
  
  sed -i "/LIBCDIO_SOURCE_PATH/s|.*|/* #undef LIBCDIO_SOURCE_PATH */|" \
    ${pkg_prefix}/usr/include/cdio/cdio_config.h
}
