pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkomparediff2
pkg_version=${_kdever}
pkg_description="Library to compare files and strings"
pkg_upstream_url='https://projects.kde.org/projects/kde/kdesdk/libkomparediff2'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kcoreaddons' 'kcodecs' 'kconfig' 'kxmlgui' 'ki18n' 'kio' 'kparts')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
#pkg_source=("git://anongit.kde.org/libkomparediff2.git")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  cd ${CACHE_PATH}
  #patch -p0 -i ${CACHE_PATH}/kio.patch
  
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-$pkg_version \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
