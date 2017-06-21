pkg_origin=cosmos

pkg_name=libpgf
pkg_version=7.15.32
pkg_description="One of the best image compression algorithms for natural images, best for natural and aerial images with a better compression efficiency than JPEG"
pkg_upstream_url="http://www.libpgf.org"
pkg_deps=('gcc-libs')
pkg_build_deps=('doxygen' 'dos2unix')
pkg_license=('GPL')
pkg_source=("https://sourceforge.net/projects/libpgf/files/libpgf/${pkg_version}-latest/libPGF-codec-and-console-src.zip")
pkg_shasum=('e0a35f768462a35060197c9d24bb07ff')

do_build() {
  dos2unix configure.ac
  
  #./autogen.sh
  autoreconf -i
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
