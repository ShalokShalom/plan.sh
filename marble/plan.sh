pkg_origin=


# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=marble
pkg_version=${_kdever}
pkg_description="Computer-aided translation"
pkg_upstream_url="https://projects.kde.org/projects/kde/kdeedu/marble/"
pkg_license=('LGPL')
pkg_deps=('gpsd' 'phonon-qt5' 'qt5-script' 'qt5-svg' 'qt5-tools' 'shapelib' 'protobuf'
         'kwallet' 'knewstuff' 'kparts' 'kcoreaddons' 'ki18n' 'krunner' 'qtwebkit-tp') # 'quazip')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/applications/${_kdever}/src/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)


do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DQT_PLUGINS_DIR=lib/qt5/plugins \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DBUILD_MARBLE_TOOLS=YES \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_MARBLE_TESTS=NO 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  #rm ${pkg_prefix}/usr/share/applications/marble-mobile.desktop
  #rm ${pkg_prefix}/usr/share/applications/marble-qt.desktop
  rm ${pkg_prefix}/usr/share/applications/marble_gpx.desktop
  rm ${pkg_prefix}/usr/share/applications/marble_kml.desktop
  #rm ${pkg_prefix}/usr/share/applications/marble_osm.desktop
  rm ${pkg_prefix}/usr/share/applications/marble_shp.desktop
}
