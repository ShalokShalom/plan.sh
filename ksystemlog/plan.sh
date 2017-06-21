pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ksystemlog
pkg_version=${_kdever}
pkg_description='System log viewer tool'
pkg_upstream_url='http://kde.org/applications/system/ksystemlog/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kxmlgui' 'kcoreaddons' 'kwidgetsaddons' 'kitemviews' 'kiconthemes' 'kio' 'kconfig' 'karchive'
         'ki18n' 'kcompletion' 'ktextwidgets')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/applications/$_kdever/src/${pkg_name}-$_kdever.tar.xz"
        'syslog-path.patch'
        "https://github.com/KDE/ksystemlog/commit/2e0261bb8fc11a0c70eaccf696ac0ba0cc5647e5.diff")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         '5486c901f707d7ea191eed58d3aef2c1'
         'e5797dd2e532e809b8607e6c928c2575')

do_prepare() {
  cd $pkg_name-${pkg_version}
  
  sed -i -e 's|<Action name="kernelLogMode" />|<Action name="cupsLogMode" />|' src/ksystemlogui.rc
  sed -i -e 's|i18n("System Log")|i18n("Pacman Log")|' src/modes/system/systemLogMode.cpp
  patch -p1 -i ${CACHE_PATH}/syslog-path.patch
  # build fix for 17.04.1
  #patch -p1 -i ${CACHE_PATH}/2e0261bb8fc11a0c70eaccf696ac0ba0cc5647e5.diff
}

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
