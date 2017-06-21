pkg_origin=cosmos

pkg_name=libieee1284
pkg_version=0.2.11
pkg_description="A library to query devices connected in parallel port."
pkg_license=('GPL2')
pkg_upstream_url="http://cyberelk.net/tim/libieee1284"
pkg_deps=('python2')
pkg_source=("http://downloads.sourceforge.net/sourceforge/libieee1284/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('b8fff9f3d121531bc17430e3f4ea6ed0')

do_build() {
  
  ./configure --prefix=/usr --mandir=/usr/share/man
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix}/ install
}
