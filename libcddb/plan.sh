pkg_origin=cosmos

pkg_name=libcddb
pkg_version=1.3.2
pkg_description="Library that implements the different protocols (CDDBP, HTTP, SMTP) to access data on a CDDB server"
pkg_upstream_url="http://sourceforge.net/projects/libcddb/"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("http://downloads.sourceforge.net/sourceforge/libcddb/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('8bb4a6f542197e8e9648ae597cd6bc8a')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
