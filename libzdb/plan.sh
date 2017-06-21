pkg_origin=cosmos

pkg_name=libzdb
pkg_version=3.1
pkg_description="Zild Database Library"
pkg_upstream_url="http://www.tildeslash.com/libzdb/"
pkg_license=('GPL')
pkg_deps=('postgresql-libs' 'sqlite' 'mariadb')
pkg_source=("http://www.tildeslash.com/libzdb/dist/libzdb-${pkg_version}.tar.gz")
pkg_shasum=('01d8519a596d62f6b43559cc29ecd36d')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
} 
