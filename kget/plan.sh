pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kget
#pkg_version=${_kdever}
pkg_version=16.11.70
_commit=3336063f2b7b5c793a9f23c929097844878d629d
pkg_description='Download Manager'
pkg_upstream_url='http://kde.org/applications/internet/kget/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcompletion' 'kwidgetsaddons' 'kcoreaddons' 'kwallet' 'kconfig' 'kdbusaddons' 'ki18n'
         'kconfigwidgets' 'knotifications' 'kio' 'kdelibs4support' 'kiconthemes' 'kcmutils' 
         'knotifyconfig' 'solid'
         'libmms' 'gpgme' 'qca-qt5' 'libktorrent')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
#pkg_source=("$_mirror/${_pkg_name}-$_kdever.tar.xz")
#pkg_shasum=(`grep ${_pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
pkg_source=("https://github.com/KDE/kget/archive/${_commit}.zip")
pkg_shasum=('a73992f887e9d2483adcea09f70a1c1e')

do_prepare() {
  cd ${pkg_name}-${_commit}
  #sed -i -e 's|find_package(Qca 2.1.0)|find_package(Qca 2.1.0 NAMES Qca-qt5 Qca)|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
  #sed -i -e 's|find_package(KF5QGpgme)||' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
  #sed -i -e 's|if(KF5Gpgme_FOUND)|if(KF5Gpgmepp_FOUND)|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
  
}

do_build() {
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
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

