pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdiagram
#pkg_version=${_kdever}
pkg_version=2.6.0
_commit=8bf3a958316609a581243443075725523dec998d
pkg_description='Powerful libraries (KChart, KGantt) for creating business diagrams'
pkg_upstream_url='https://github.com/KDE/kdiagram/'
pkg_license=('LGPL')
pkg_deps=('qt5-svg')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("http://download.kde.org/stable/kdiagram/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('a767fbe0b4e90ccc48e83ad04c47cf8b')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
