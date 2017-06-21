pkg_origin=

pkg_name=nomacs
pkg_version=3.6.1
pkg_description="Qt based image viewer for all common image formats including RAW and psd images."
pkg_upstream_url="http://www.nomacs.org/"
pkg_license=('GPL3')
pkg_deps=('qt5-svg' 'exiv2' 'libraw' 'opencv' 'qt5-imageformats')
pkg_build_deps=('cmake' 'qt5-tools')
pkg_source=("https://github.com/nomacs/nomacs/archive/${pkg_version}.tar.gz"
        'qdrag.diff')
pkg_shasum=('67e2600b4a1c83e7b78d4d41f7c2f89f'
         'bdd31541310ed5b6bee1c8f101ef3505')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #patch -p1 -i $CACHE_PATH/qdrag.diff
  #sed -i 's|OpenCV 2.1.0 REQUIRED|OpenCV 3.1.0 REQUIRED|g' $CACHE_PATH/$pkg_name-$pkg_version/cmake/Unix.cmake

}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version}/ImageLounge \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DQT_QMAKE_EXECUTABLE=/usr/lib/qt5/bin/qmake
    #-DUSE_SYSTEM_QUAZIP=ON 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix}/ install
}
