pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kxmlrpcclient
pkg_version=${_kf5ver}
epoch=1
pkg_description="Interaction with XMLRPC services."
pkg_upstream_url='https://projects.kde.org/projects/kde/pim/kxmlrpcclient'
pkg_license=('LGPL')
pkg_deps=('kio')
pkg_build_deps=('extra-cmake-modules' 'git')
pkg_source=($_mirror/${pkg_name}-${_kf5ver}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`)

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
  # locale conflicts with plasma-workspace, re-add with plasma 5.3
  #rm -r ${pkg_prefix}/usr/share
}
