pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kcoreaddons
pkg_version=${_kf5ver}
pkg_description='Utilities for core application functionality and accessing the OS'
pkg_upstream_url='https://github.com/KDE/kcoreaddons'
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'shared-mime-info' 'gamin')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("https://download.kde.org/unstable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/KDE/kcoreaddons/commit/2a9b56e9340760822b1dfece73bc045c64033ef1.diff")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`
         '0a16a78e750273b89e4a959f6fbc490b')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  #patch -p1 -i ${CACHE_PATH}/2a9b56e9340760822b1dfece73bc045c64033ef1.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
