pkg_origin=

pkg_name=kmymoney
pkg_version=4.100.9
_commit=5448a2831198e45b9501801baeb19f341440f5c6
pkg_description="An finance manager for KDE with HBCI support"
pkg_upstream_url="http://www.kmymoney.org/"
pkg_license=('GPL')
pkg_deps=('kcoreaddons' 'kconfig' 'ki18n' 'khtml' 'kdelibs4support' 'kcompletion' 'kcmutils' 'kitemviews' 'kservice' 'kwallet' 
         'kholidays' 'gpgme' 'kcontacts' 'akonadi-contacts' 'akonadi' 'kidentitymanagement' 'kross'
         'shared-mime-info' 'boost-libs' 'pulseaudio' 'libofx' 'libical' 'alkimia' 'kdiagram'
         'kactivities' 'aqbanking') # 'sqlcipher' looks for Qt4 versions)
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'docbook-xsl' 'boost')  
pkg_source=("https://github.com/KDE/kmymoney/archive/${_commit}.zip")
pkg_shasum=('b75ee14c5837204a81e7538893084be1')

do_build() {
  cd ${CACHE_PATH}
  #sed -e "s/#include <kstdguiitem.h>/#include <kstandardguiitem.h>/" -i ${CACHE_PATH}/$_pkg_name/kmymoney/dialogs/*.cpp
  #sed -e "s|find_package(KActivities)|find_package(KF5Activities)|" -i ${CACHE_PATH}/$pkg_name/CMakeLists.txt
  
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF \
    -DENABLE_SQLCIPHER=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
