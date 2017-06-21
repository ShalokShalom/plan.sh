pkg_origin=cosmos

pkg_name=nettle
pkg_version=3.3
pkg_description="Nettle - a low-level cryptographic library."
pkg_upstream_url="http://www.lysator.liu.se/~nisse/nettle/"
pkg_license=('GPL')
pkg_deps=('gmp')
pkg_source=("http://ftp.gnu.org/gnu/nettle/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('10f969f78a463704ae73529978148dbe')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr --libdir=/usr/lib --enable-shared
  make
}

do_check() {
  cd ${pkg_name}-${pkg_version}
  
  make -k check
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
