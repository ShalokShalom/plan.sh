pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kf5-attica
_pkg_name=attica
pkg_version=${_kdever}
pkg_upstream_url='https://projects.kde.org/projects/kdesupport/attica'
pkg_description='A Qt5 library that implements the Open Collaboration Services API'
pkg_license=('LGPL')
pkg_deps=('qt5-base')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/frameworks/${pkg_version}/${_pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${_pkg_name}-$_kdever.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DLIB_INSTALL_DIR=lib
  make
}

do_package() {
  cd build
  make DESTDIR="${pkg_prefix}" install
}
