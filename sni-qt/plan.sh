pkg_origin=cosmos

pkg_name=sni-qt
pkg_version=0.2.6
pkg_description='A Qt plugin which turns all QSystemTrayIcon into StatusNotifierItems (appindicators)'
pkg_upstream_url='https://launchpad.net/sni-qt'
pkg_license=('LGPL3')
pkg_deps=('libdbusmenu-qt')
pkg_build_deps=('cmake')
backup=('etc/sni-qt.conf')
pkg_source=("http://launchpad.net/sni-qt/trunk/${pkg_version}/+download/${pkg_name}-${pkg_version}.tar.bz2"
        'sni-qt.conf')
pkg_shasum=('e84c66e776f7c22c961817387f618c81'
         '1b3ed5aba470a3539209b34ab637ff48')

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm644 ${CACHE_PATH}/sni-qt.conf ${CACHE_PATH}/etc/sni-qt.conf
}
