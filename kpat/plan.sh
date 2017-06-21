pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kpat
pkg_version=${_kdever}
pkg_description="Collection of various patience games known all over the world"
pkg_upstream_url='http://www.kde.org'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kconfig' 'kwidgetsaddons' 'kdbusaddons' 'kdeclarative' 'ki18n' 'kguiaddons'
         'kconfigwidgets' 'kitemviews' 'kiconthemes' 'kcompletion' 'ktextwidgets' 'kxmlgui' 'kio'
         'kdelibs4support' 'knotifyconfig' 'knewstuff' 'libkdegames' 'phonon-qt5')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
  
  #sed -i 's|Exec=kpat -caption %c %u|Exec=kpat -qwindowtitle %c|' ${pkg_prefix}/usr/share/applications/org.kde.kpat.desktop
  #sed -i 's|X-DBUS-StartupType=Multi|#X-DBUS-StartupType=Multi|' ${pkg_prefix}/usr/share/applications/org.kde.kpat.desktop
}

