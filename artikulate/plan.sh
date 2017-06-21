pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=artikulate
pkg_version=${_kdever}
#pkg_version=15.07.70
pkg_description="Improve your pronunciation by listening to native speakers."
pkg_upstream_url='https://projects.kde.org/projects/kde/kdeedu/artikulate'
pkg_license=('LGPL')
pkg_deps=('kconfig' 'kconfigwidgets' 'kcoreaddons' 'kdeclarative' 'ki18n' 'kio' 'knewstuff'
         'kwidgetsaddons' 'kxmlgui' 'qt5-gstreamer' 'qt5-multimedia')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/artikulate.git#branch=frameworks")
#pkg_shasum=('SKIP')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's/${DATA_INSTALL_DIR}/${KXMLGUI_INSTALL_DIR}/' ${CACHE_PATH}/${pkg_name}/src/CMakeLists.txt
}

do_build() {
  cd ${CACHE_PATH}

  mkdir build
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd ${CACHE_PATH}/build
  
  make DESTDIR=${pkg_prefix} install
}
