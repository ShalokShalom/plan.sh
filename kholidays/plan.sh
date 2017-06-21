pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kholidays
pkg_version=${_kdever}
pkg_description="Library that provides a C++ API that determines holiday and other special events for a 
         geographical region.."
pkg_upstream_url='https://projects.kde.org/projects/kde/pim/kholidays'
pkg_license=('LGPL')
pkg_deps=('kitemviews' 'kdelibs4support' 'qt5-tools')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz
        'revert_tr.patch')
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         '771d8857d040238c2d77b43999c00745')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's|if (isnan(delta))|if (std::isnan(delta))|' src/sunriseset.cpp
  patch -p1 -i ${CACHE_PATH}/revert_tr.patch
}

do_build() {
  mkdir build
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
