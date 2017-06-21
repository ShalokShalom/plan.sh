pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdesu
pkg_version=${_kdever}
pkg_description='User interface for running shell commands with root privileges'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kdesu'
pkg_license=('LGPL')
pkg_deps=('kservice' 'kpty' 'libx11')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/unstable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  #sed -i "/kdesu_stub/s:QByteArray:QByteArray(CMAKE_INSTALL_PREFIX) + \"/\" + &:g" ${CACHE_PATH}/${pkg_name}-${pkg_version}/src/suprocess.cpp
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DLIBEXEC_INSTALL_DIR=lib \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
