pkg_origin=cosmos

pkg_name=jfsutils
pkg_version=1.1.15
pkg_description="JFS filesystem utilities"
pkg_upstream_url="http://jfs.sourceforge.net"
pkg_license=('GPL')
pkg_deps=('e2fsprogs' 'util-linux')
pkg_source=("http://jfs.sourceforge.net/project/pub/${pkg_name}-${pkg_version}.tar.gz"
        'inttypes.patch')
pkg_shasum=('8809465cd48a202895bc2a12e1923b5d'
         '444078802d798606be9e32fda7cf7376')

do_build() {
  cd ${pkg_name}-${pkg_version}
  patch -p1 -i ${CACHE_PATH}/inttypes.patch
  
  ./configure --prefix=/usr --sbindir=/sbin 
  make
}

do_check() {
  cd ${pkg_name}-${pkg_version}
  
  make check
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}

