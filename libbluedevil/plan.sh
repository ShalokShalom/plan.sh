pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libbluedevil
pkg_version=${_plasmaver}
pkg_description='Qt wrapper for bluez used in the new KDE bluetooth stack'
pkg_upstream_url="https://projects.kde.org/projects/playground/libs/libbluedevil"
pkg_license=('GPL')
pkg_deps=('qt5-base' 'bluez')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build(){
  cd ${CACHE_PATH}
  
  mkdir build
  cd build
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd ${CACHE_PATH}/build
  
  make DESTDIR=${pkg_prefix} install
}
