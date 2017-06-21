pkg_origin=

pkgbase=transmission
pkg_name=('transmission-cli' 'transmission-qt')
pkg_version=2.92
pkg_upstream_url="http://www.transmissionbt.com/"
pkg_license=('GNU GPLv2')
pkg_build_deps=('intltool' 'curl' 'pkgconfig' 'desktop-file-utils' 'qt5-declarative' 'libevent'
             'gettext' 'cmake' 'qt5-tools' 'miniupnpc')
pkg_source=("https://github.com/transmission/transmission-releases/raw/master/${pkgbase}-${pkg_version}.tar.xz"
#pkg_source=("https://build.transmissionbt.com/job/trunk-linux/lastBuild/artifact/transmission-trunk-r14679.tar.xz"
        'transmission.systemd'
        'transmission.tmpfiles'
        'dbushelper.diff'
        'transmission.svg'
        'transmission-tray.svg'
        'transmission-tray-dark.svg')
pkg_shasum=('3fce404a436e3cd7fde80fb6ed61c264'
         '5c289c8901221a94be74665368ab5c2c'
         '23f2320361ad54373c3a4551ef634fe8'
         '796d52f26433300767ce16f8c92eebfb'
         '019c6e9dbdcdb2704a266874d02975c0'
         'dbbc3c6ce0707808895778bd81e36707'
         'c4d8952b3280d99d909ccfbd48940a0a')
        
prepare () {
  cd ${pkgbase}-${pkg_version}

  #patch -p1 -i $CACHE_PATH/dbushelper.diff
}  

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkgbase}-${pkg_version} \
        -DENABLE_TESTS=OFF \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DENABLE_GTK=OFF \
        -DENABLE_QT=ON \
        -DENABLE_CLI=ON \
        -DUSE_QT5=ON \
        -DINSTALL_LIB=OFF \
        -DWITH_CRYPTO="openssl" \
        -DWITH_INOTIFY=ON
     
      make
}

package_transmission-cli() {
  pkg_description="Fast, easy, and free BitTorrent client (CLI tools, daemon and web client)"
  pkg_deps=('curl' 'libevent')
  groups=('network')

  cd build

  for dir in daemon cli utils
  do
      make -C ${dir} DESTDIR=${pkg_prefix} install
  done

  install -D -m644 ${CACHE_PATH}/transmission.systemd ${pkg_prefix}/usr/lib/systemd/system/transmission.service
  install -D -m644 ${CACHE_PATH}/transmission.tmpfiles ${pkg_prefix}/usr/lib/tmpfiles.d/transmission.conf
  install -D -m644 ${CACHE_PATH}/${pkgbase}-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/transmission-cli/COPYING
}

package_transmission-qt() {
  pkg_description="Fast, easy, and free BitTorrent client (Qt GUI)"
  pkg_deps=('curl' 'qt5-declarative' 'libevent' 'miniupnpc')
  optpkg_deps=('transmission-cli: daemon support')
  groups=('network')
  install=transmission-qt.install

  cd build/qt
  make DESTDIR=${pkg_prefix} install
  
  cd ../..

  install -D -m644 ${pkgbase}-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/transmission-qt/COPYING
  install -D -m644 ../transmission.svg ${pkg_prefix}/usr/share/pixmaps/transmission.svg
  install -D -m644 ../transmission-tray.svg ${pkg_prefix}/usr/share/pixmaps/transmission-tray.svg
  install -D -m644 ../transmission-tray-dark.svg ${pkg_prefix}/usr/share/icons/breeze-dark/apps/48/transmission-tray.svg
}
