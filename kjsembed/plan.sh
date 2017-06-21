pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kjsembed
pkg_version=${_kdever}
pkg_description='KJSEmbed'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kjsembed'
pkg_license=('LGPL')
pkg_deps=('ki18n' 'qt5-svg')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools')
pkg_source=("http://download.kde.org/unstable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
