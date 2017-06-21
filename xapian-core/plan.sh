pkg_origin=cosmos

pkg_name=xapian-core
pkg_version=1.4.4
pkg_description='Open source search engine library.'
pkg_upstream_url='https://www.xapian.org/'
pkg_license=('GPL')
pkg_deps=('sh' 'gcc-libs' 'zlib' 'util-linux')
pkg_source=("https://oligarchy.co.uk/xapian/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('919ad9a80a7c6a01ab4721670bb29cab')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
