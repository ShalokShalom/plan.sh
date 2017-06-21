pkg_origin=cosmos

pkg_name=libssh2
pkg_version=1.8.0
pkg_description="A library implementing the SSH2 protocol as defined by Internet Drafts"
pkg_upstream_url="https://www.libssh2.org/"
pkg_license=('BSD')
pkg_deps=('openssl')
pkg_build_deps=('zlib')
pkg_source=("https://www.libssh2.org/download/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('3d1147cae66e2959ea5441b183de1b1c')

do_build() {
  cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr 
  make 
}

do_package() {
  cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install 
  
  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE 
}
