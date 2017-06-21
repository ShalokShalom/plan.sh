pkg_origin=

pkg_name=qtkeychain
pkg_version=0.8.0
pkg_description="Qt API to store passwords and other secret data securely"
pkg_upstream_url="https://github.com/frankosterfeld/qtkeychain"
pkg_license=('BSD')
pkg_deps=('qt5-base' 'kwallet')
pkg_build_deps=('cmake' 'qt5-tools' 'icu')
pkg_source=("https://github.com/frankosterfeld/qtkeychain/archive/v${pkg_version}.tar.gz")
pkg_shasum=('d741e7e55ae48a130cb95264fbe732b7')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_INSTALL_LIBEXECDIR=lib/${pkg_name} 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ${CACHE_PATH}/qtkeychain-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
