pkg_origin=cosmos

pkg_name=vstream-client
pkg_version=1.2.1.1
pkg_description="A fork off of the vstream library from the tivo-mplayer project."
pkg_license=('GPL')
pkg_upstream_url="http://vstream-client.googlecode.com"
pkg_deps=()
pkg_build_deps=()
pkg_source=("http://${pkg_name}.googlecode.com/files/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('4f2fc3e5835592f5d8c230aaacd6a7b6')

do_build() {
  
  ./configure --prefix=${CACHE_PATH}/usr
  make ${pkg_name}
}

do_package() {
  
  make INSTALL='install -D' install
}
