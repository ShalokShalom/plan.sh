pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=gpgmepp
pkg_version=${_kdever}
pkg_description="C++ wrapper (or C++ bindings) for the GnuPG project's gpgme (GnuPG Made Easy) library"
pkg_upstream_url='https://projects.kde.org/projects/kde/pim/gpgmepp'
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'gpgme')
pkg_build_deps=('extra-cmake-modules' 'git' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/gpgmepp.git")
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
