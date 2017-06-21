pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kactivities-stats
pkg_version=${_kf5ver}
pkg_description="Library for accessing the usage data collected by the activities system."
pkg_upstream_url='https://github.com/KDE/kactivities-stats'
pkg_license=('LGPL')
pkg_deps=('boost-libs' 'kconfig' 'kactivities')
pkg_build_deps=('extra-cmake-modules' 'boost')
pkg_source=("http://download.kde.org/stable/frameworks/5.21/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
  
  #patch -p1 -i ${CACHE_PATH}/plugin_dir.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DQT_PLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
