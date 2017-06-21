pkg_origin=cosmos

pkg_name=liblo
pkg_version=0.28
pkg_description="Lightweight OSC implementation: an implementation of the Open Sound Control protocol for POSIX systems"
pkg_upstream_url="http://plugin.org.uk/liblo/"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("http://downloads.sourceforge.net/liblo/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('e2a4391a08b49bb316c03e2034e06fa2')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=$pkg_prefix install
}
