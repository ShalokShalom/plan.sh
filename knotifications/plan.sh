pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=knotifications
pkg_version=${_kf5ver}
pkg_description='KNotifications'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/knotifications'
pkg_license=('LGPL')
pkg_deps=('kiconthemes' 'kservice' 'kwindowsystem' 'libdbusmenu-qt5' 'libxslt' 'phonon-qt5' 'qt5-speech')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("http://download.kde.org/stable/frameworks/5.11/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
