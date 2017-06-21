pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkface
pkg_version=${_kdever}
pkg_description="Qt/C++ library to perform face detection and recognition over pictures"
pkg_upstream_url="http://www.digikam.org/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('ki18n' 'opencv')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#groups=('kde' 'kdeedu' 'kde-uninstall' 'education')
pkg_source=("http://download.kde.org/stable/applications/${_kdever}/src/${pkg_name}-$_kdever.tar.xz"
        'https://github.com/KDE/libkface/commit/0684ee86b6510423bdd79325cd769e7a7c3d0e7c.diff')
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         'f9a71330409a5f0d250f1f7970db94f3')
#pkg_source=("git://anongit.kde.org/libkface.git")
#pkg_shasum=('SKIP')

do_prepare() {
   cd $pkg_name-${pkg_version}
   sed -i -e 's|OPENCV_TEST_VERSION(3,1,0)|OPENCV_TEST_VERSION(3,2,0)|' src/recognition-opencv-lbph/facerec_borrowed.cpp
   sed -i -e 's|OPENCV_TEST_VERSION(3,1,0)|OPENCV_TEST_VERSION(3,2,0)|' src/recognition-opencv-lbph/facerec_borrowed.h
   patch -p1 -i ${CACHE_PATH}/0684ee86b6510423bdd79325cd769e7a7c3d0e7c.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF \
    -DENABLE_OPENCV3=ON
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
