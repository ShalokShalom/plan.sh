pkg_origin=cosmos

pkg_name=cppunit
pkg_version=1.14.0
pkg_description="A C++ unit testing framework"
pkg_upstream_url="http://cppunit.sourceforge.net"
pkg_license=('LGPL')
pkg_deps=('sh' 'gcc-libs')
pkg_build_deps=('gcc')
pkg_source=("http://dev-www.libreoffice.org/src/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('7ad93022171710a541bfe4bfd8b4a381')

do_build() {
   
   ./configure --prefix=/usr --disable-static
   make
}

check() {
  
  make -k check
}

do_package() {
   
   make DESTDIR=${pkg_prefix} install
}
