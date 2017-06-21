pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kactivities
pkg_version=${_kf5ver}
pkg_description="Core components for the KDE's Activities"
pkg_upstream_url='https://github.com/KDE/kactivities'
pkg_license=('LGPL')
pkg_deps=('qt5-declarative' 'boost-libs' 'kdbusaddons' 'kio' 'kwindowsystem' 'kservice' 'kdeclarative'
         'kcmutils')
pkg_build_deps=('extra-cmake-modules' 'boost')
pkg_source=("http://download.kde.org/stable/frameworks/5.25/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  #patch -p1 -i ${CACHE_PATH}/plugin_dir.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DKDE_INSTALL_QTPLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
