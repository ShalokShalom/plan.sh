pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kross
pkg_version=${_kf5ver}
pkg_description='Kross'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kross'
pkg_license=('LGPL')
pkg_deps=('kparts')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools')
pkg_source=("http://download.kde.org/stable/frameworks/5.12/portingAids/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
