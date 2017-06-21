pkg_origin=cosmos

pkg_name=xerces-c
pkg_version=3.1.4
pkg_description="A validating XML parser written in a portable subset of C++."
pkg_upstream_url="http://xerces.apache.org/xerces-c"
pkg_license=('APACHE')
pkg_deps=('gcc-libs' 'curl' 'icu')
pkg_source=("http://apache.osuosl.org/xerces/c/3/sources/xerces-c-${pkg_version}.tar.gz")
pkg_shasum=('21bb097b711a513275379b59757cba4c')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH}/ install
}
