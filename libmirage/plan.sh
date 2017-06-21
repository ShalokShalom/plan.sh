pkg_origin=cosmos

pkg_name=libmirage
pkg_version=3.0.3
pkg_description="CD-ROM image (B6T/CCD/CDI/CUE/ISO/MDS/NRG/TOC) access library"
pkg_upstream_url="http://cdemu.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('glib2' 'libsamplerate' 'zlib' 'bzip2' 'shared-mime-info')
pkg_build_deps=('bison' 'flex' 'cmake' 'gobject-introspection')
pkg_source=("http://downloads.sourceforge.net/cdemu/$pkg_name-$pkg_version.tar.bz2")
pkg_shasum=('fd0009ced98ef47c94d2919eafcaa099')

do_build() {
  
  mkdir build
  cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DPOST_INSTALL_HOOKS:BOOL=OFF
  make
}

do_package() {
  
  make DESTDIR=$pkg_prefix install
}
