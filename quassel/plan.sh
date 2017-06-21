pkg_origin=

pkg_name=quassel
pkg_version=0.12.4
pkg_description="Qt irc client with a separated core"
pkg_upstream_url="http://quassel-irc.org"
pkg_license=('GPL')
pkg_deps=('qt5-script' 'hicolor-icon-theme' 'inxi' 'libdbusmenu-qt5' 'phonon-qt5'
         'kconfigwidgets' 'kcoreaddons' 'knotifications' 'knotifyconfig' 'ktextwidgets' 'kwidgetsaddons'
         'kxmlgui' 'sonnet' 'qca-qt5' 'qtwebkit-tp')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("http://quassel-irc.org/pub/quassel-${pkg_version}.tar.bz2"
#pkg_source=("git://github.com/quassel/quassel.git"
        'quassel.service'
        'quassel.conf'
        'irc-channel-active.svgz'
        'irc-channel-inactive.svgz'
        'quassel.png'
        "https://github.com/sandsmark/quassel/commit/56e1d275c2f8a59eaf9d19ba76aca5f1d3163683.diff")
install=quassel.install
backup=(etc/conf.d/quassel.conf)
pkg_shasum=('56abcde46decc5e341888a05189cece3'
         '7f56b8d2d54a1395ed8bada023ec710c'
         '479229556ba0dd94e3ce28e31e5deea9'
         'd22180823cda2ac7bedb238463714c15'
         '79f0e1c5261fefeb10cd53c1b01e64ef'
         '55a01e2e1a15bf4328638f8f27b7383f'
         'c746703719f94932cef4285812c0277f')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # spellchecking through sonnet
  #patch -p1 -i ${CACHE_PATH}/56e1d275c2f8a59eaf9d19ba76aca5f1d3163683.diff
}
         
do_build() {
  mkdir build
  cd build

  cmake \
    -DCMAKE_INSTALL_PREFIX=/usr/ \
    -DUSE_QT5=ON \
    -DWITH_WEBKIT=ON \
    -DWITH_KDE=ON \
    -DCMAKE_BUILD_TYPE="Release" \
    -DHAVE_SSL=ON \
    ../${pkg_name}-${pkg_version} \
    -Wno-dev

  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install

  install -D ${CACHE_PATH}/$pkg_name.service ${pkg_prefix}/usr/lib/systemd/system/$pkg_name.service
  install -D -m644 ${CACHE_PATH}/$pkg_name.conf ${pkg_prefix}/etc/conf.d/$pkg_name
  
  #rm ${pkg_prefix}/usr/share/icons/hicolor/scalable/status/irc*
  rm ${pkg_prefix}/usr/share/pixmaps/quassel.png
  install -m 644 -p ${CACHE_PATH}/irc-channel* ${pkg_prefix}/usr/share/icons/hicolor/scalable/status/
  #install -D ${CACHE_PATH}/irc-channel-inactive.svgz ${pkg_prefix}/usr/share/apps/quassel/icons/oxygen/scalable/irc*
  install -m 644 -p ${CACHE_PATH}/quassel.png ${pkg_prefix}/usr/share/pixmaps/
  # set default channel to KaOS
  sed -i -e 's|DefaultChannels=#quassel|DefaultChannels=#kaosx|' ${pkg_prefix}/usr/share/quassel/networks.ini
}

