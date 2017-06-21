pkg_origin=

pkg_name=podofo
pkg_version=0.9.5
pkg_description="PoDoFo is a library to work with the PDF file format."
pkg_upstream_url="http://podofo.sourceforge.net"
pkg_license=('GPL')
pkg_deps=( 'openssl' 'fontconfig' 'libpng' 'libtiff' 'lua' 'libidn')
pkg_build_deps=( 'cmake' )
pkg_source=("http://downloads.sourceforge.net/podofo/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('4751a6cf41250bea550a73ff960b7228')

do_build() {
  cd ${pkg_name}-${pkg_version}

  mkdir -p build
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=/usr .. \
        -DPODOFO_BUILD_SHARED=1 \
        -DPODOFO_HAVE_JPEG_LIB=1 \
        -DPODOFO_HAVE_PNG_LIB=1 \
        -DPODOFO_HAVE_TIFF_LIB=1
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}/build
  
  make DESTDIR=$pkg_prefix install
}

