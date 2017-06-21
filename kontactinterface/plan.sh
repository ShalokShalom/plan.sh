pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kontactinterface
pkg_version=${_kdever}
pkg_description="Library that provides the glue necessary for application parts to be embedded as a Kontact 
         component (or plugin)."
pkg_upstream_url='https://projects.kde.org/projects/kde/pim/kontactinterface'
pkg_license=('LGPL')
pkg_deps=('kparts' 'libx11')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  #patch -p1 -i $CACHE_PATH/qt5.5.diff
}

do_build() {
  cd ${CACHE_PATH}
  mkdir build
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd ${CACHE_PATH}/build
  
  make DESTDIR=${pkg_prefix} install
}
