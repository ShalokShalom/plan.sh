pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=breeze-icons
pkg_version=${_kf5ver}
pkg_description='Breeze icon theme.'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/breeze-icons'
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'kconfig' 'kiconthemes')
pkg_build_deps=('extra-cmake-modules')
#groups=('kf5')
pkg_source=("http://download.kde.org/stable/frameworks/5.16/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

prepare () {
  cd ${pkg_name}-${pkg_version}
  #sed -i -e 's|actions apps categories|actions applets apps categories|' icons/CMakeLists.txt
  #sed -i -e 's|actions apps categories|actions applets apps categories|' icons-dark/CMakeLists.txt
}
  
build () {  
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBINARY_ICONS_REpkg_source=ON
  make
}

package () {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}

