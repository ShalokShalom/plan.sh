pkg_origin=

pkg_name=qt5-gstreamer
_pkg_name=qt-gstreamer
pkg_version=1.2.0
pkg_description="Qt5 bindings for GStreamer"
pkg_upstream_url="http://gstreamer.freedesktop.org/modules/qt-gstreamer.html"
pkg_license=('LGPL2.1')
pkg_deps=('qt5-declarative' 'gst-plugins-good')
pkg_build_deps=('cmake' 'boost' 'flex' 'bison')
optpkg_deps=('libgles: required for OpenGLES rendering support in qtvideosink (embedded only)')
pkg_source=("http://gstreamer.freedesktop.org/src/qt-gstreamer/${_pkg_name}-${pkg_version}.tar.xz"
        'gstreamer1.6.patch')
#pkg_source=("https://github.com/detrout/qt-gstreamer.git")
pkg_shasum=('fd794045a828c184acc1794b08a463fd'
         '25446ce5c7948a8a0b0599d380fed03e')

do_prepare() {
  cd ${_pkg_name}-${pkg_version}
  patch -p1 -i ${CACHE_PATH}/gstreamer1.6.patch
}

do_build() {
  cd ${CACHE_PATH} 
  #git clone -b 1.0-proposed https://github.com/detrout/qt-gstreamer.git

  mkdir build
  cd build
  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DQTGSTREAMER_EXAMPLES=OFF \
    -DQTGSTREAMER_TESTS=OFF \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DQT_VERSION=5
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix}/ install
}
