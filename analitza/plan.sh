pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=analitza
pkg_version=${_kdever}
pkg_description="Shared Math libraries from Kalgebra"
pkg_upstream_url="http://kde.org/applications/education/kalgebra/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('eigen3'  'qt5-svg')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools')
#groups=('kde' 'kdeedu' 'kde-uninstall' 'education')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_shasum=('604933c4de59d89d154b142c70cd8fd8')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
