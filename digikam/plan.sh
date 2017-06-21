pkg_origin=

pkgbase=digikam
pkg_name=('digikam' 'kipi-plugins')
pkg_version=5.5.0
_pkg_version=5.5.0
pkg_upstream_url="https://www.digikam.org/"
pkg_license=('GPL')
pkg_description="Digital photo management application for kde"
pkg_build_deps=('knotifyconfig' 'knotifications' 'kio' 'ktextwidgets' 'kcoreaddons' 'kwindowsystem'
         'solid' 'kiconthemes' 'kfilemetadata' 'libksane' 'ki18n' 'kitemmodels' 'lensfun' 
         'marble' 'qt5-x11extras' 'jasper' 'libgphoto2' 'liblqr' 'opencv'
         'lapack' 'libgpod' 'eigen3' 'mariadb' 'akonadi-contacts'
         'kparts' 'kconfig' 'kxmlgui' 'kservice' 'threadweaver' 'karchive' 'libkexiv2' 
         'libkdcraw' 'libkipi' 'libkgeomap' 'libkvkontakte' 'libmediawiki' 'libtiff'
         'kcalcore' 'kwallet' 'phonon-qt5' 
         'pkgconfig' 'extra-cmake-modules' 'kdoctools' 'doxygen' 'boost' 'imagemagick' 'clang' 'ruby')
pkg_source=("http://download.kde.org/stable/digikam/${pkgbase}-${_pkg_version}.tar.xz")
pkg_shasum=('bc45d94538f97d805f5a5edd942c56fb')

do_prepare() {
  cd ${pkgbase}-${_pkg_version}
  sed -i -e 's|add_subdirectory( sv )|#add_subdirectory( sv )|' doc-translated/CMakeLists.txt
  #sed -i -e 's|${KF5_MIN_VERSION}||' ${CACHE_PATH}/${pkgbase}-${_pkg_version}/extra/kipi-plugins/CMakeLists.txt
  #patch -p1 -i $CACHE_PATH/CMakeLists.diff
}

do_build() {
   cd ${CACHE_PATH}
 
   mkdir -p build
   cd build
   cmake ../${pkgbase}-${_pkg_version} \
     -DCMAKE_BUILD_TYPE=Release \
     -DCMAKE_INSTALL_PREFIX=/usr \
     -DKDE_INSTALL_LIBDIR=lib \
     -DCMAKE_SKIP_RPATH=ON \
     -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
     -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
     -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
     -DBUILD_TESTING=OFF \
     -DENABLE_AKONADICONTACTSUPPORT=ON \
     -DENABLE_MYSQLSUPPORT=ON \
     -DENABLE_KFILEMETADATASUPPORT=ON \
     -DENABLE_MEDIAPLAYER=OFF \
     -DENABLE_OPENCV3=ON \
     -DCMAKE_C_COMPILER=clang \
     -DDIGIKAMSC_CHECKOUT_DOC=ON \
     -DENABLE_APPSTYLES=ON
   make 
}

package_digikam() {
  pkg_description="Digital photo management application for kde"
  pkg_deps=('knotifyconfig' 'knotifications' 'kio' 'ktextwidgets' 'kcoreaddons' 'kwindowsystem'
           'solid' 'kiconthemes' 'kfilemetadata' 'kitemmodels' 'libksane' 'ki18n' 'lensfun' 
           'marble' 'qt5-x11extras' 'jasper' 'libgphoto2' 'liblqr' 'opencv'
           'kipi-plugins' 'lapack' 'libgpod' 'eigen3' 'mariadb' 'kdepimlibs')
  groups=('graphics')
  
  cd ${CACHE_PATH}/build/core
  make DESTDIR=${pkg_prefix}/ install
  
  cd ${CACHE_PATH}/build/doc
  make DESTDIR=${pkg_prefix}/ 
}

package_kipi-plugins () {
  pkg_description="Collection of plugins extending the KDE graphics and image applications as digiKam, Gwenview, and KPhotoalbum."
  pkg_deps=('kparts' 'kconfig' 'kiconthemes' 'kwindowsystem' 'kxmlgui' 'kio' 'kservice'
           'threadweaver' 'karchive' 'ki18n' 'libkexiv2' 'libkdcraw' 'libkipi' 'libkgeomap' 
           'libkvkontakte' 'libmediawiki' 'libtiff'
           'kcalcore' 'kwallet' 'phonon-qt5') # 'libkface') 
  optpkg_deps=('hugin-tools: to work with the panorama tool')
  groups=('kde' 'kde-graphics' 'kde-uninstall')
  
  cd ${CACHE_PATH}/build/extra/kipi-plugins
  make DESTDIR=${pkg_prefix}/ install
  
  cd ${CACHE_PATH}/build/po
  make DESTDIR=${pkg_prefix}/ install
}

