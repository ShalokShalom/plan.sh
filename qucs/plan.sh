pkg_origin=

pkg_name=qucs
pkg_version=0.0.18
pkg_description="An integrated circuit simulator with a graphical user interface"
pkg_upstream_url="http://qucs.sourceforge.net"
pkg_license=('GPL')
pkg_deps=('gcc-libs' 'qt')
pkg_source=("http://downloads.sourceforge.net/project/qucs/qucs/$pkg_version/qucs-$pkg_version.tar.gz")
pkg_shasum=('4985d66565e8c29c9e6d7e7c98781e60')

do_build() {
  cd $CACHE_PATH/$pkg_name-${pkg_version/s/.}
  
  ./configure --prefix=/usr
  make
}

do_package() {
  cd $CACHE_PATH/$pkg_name-${pkg_version/s/.}
  
  make DESTDIR=$pkg_prefix install
}
