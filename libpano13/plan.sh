pkg_origin=cosmos

pkg_name=libpano13
pkg_version=2.9.19
pkg_description="Basic library to calculate panoramical pictures - core functions of the panotools"
pkg_upstream_url="http://panotools.sourceforge.net/"
pkg_license=('GPL2')
pkg_deps=('libpng' 'libtiff')
pkg_build_deps=('openjdk')
pkg_source=("http://downloads.sourceforge.net/sourceforge/panotools/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('1e4ce42f58a3f22c0a97d0b7a8e1dbb0')

do_build() {
  
  ./configure --prefix=/usr --mandir=/usr/share/man --with-java=${JAVA_HOME}
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
