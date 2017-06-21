pkg_origin=cosmos

pkg_name=tclap
pkg_version=1.2.1
pkg_description="Small, flexible library providing a simple interface for defining command line arguments"
pkg_upstream_url="http://tclap.sourceforge.net/"
pkg_license=('MIT')
pkg_source=("http://downloads.sourceforge.net/sourceforge/tclap/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('eb0521d029bf3b1cc0dcaa7e42abf82a')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  install -D -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
