pkg_origin=cosmos

pkg_name=opencv
pkg_version=3.2.0
_pkg_version=3.2.0
pkg_description="Open Source Computer Vision Library"
pkg_license=('BSD')
pkg_upstream_url="http://opencv.org/"
pkg_deps=('jasper' 'gst-plugins-base' 'openexr' 'libdc1394' 'v4l-utils' 'ffmpeg' 'qt5-base'
         'libgphoto2' 'libwebp' 'protobuf')
pkg_build_deps=('pkgconfig' 'cmake' 'python2-numpy' 'eigen3' 'python2-sphinx' 'mesa')
pkg_deps=('python2-numpy: Python 2.x interface' 'eigen3')
pkg_source=("https://github.com/Itseez/opencv/archive/${_pkg_version}.tar.gz"
        "opencv_contrib-${_pkg_version}::https://github.com/Itseez/opencv_contrib/archive/${_pkg_version}.tar.gz"
        "https://github.com/alalek/opencv/commit/24dbb43c096691d0333cacf231e22f1369f8c826.patch"
        'opengl.diff')
pkg_shasum=('a43b65488124ba33dde195fea9041b70'
         'd7d50c70c31df3b31310f548f31fd2a2'
         '5bd9cd736b171c15cedee3a32a0c47ff'
         '20bc30c514f6f01cfbaaa7e1e0fcb39b')

do_build() {
  # fix cannot find -lippicv when building with opencv 3.1.0
  #patch -p1 -i ${CACHE_PATH}/24dbb43c096691d0333cacf231e22f1369f8c826.patch
  #patch -p1 -i ${CACHE_PATH}/opengl.diff
 
  mkdir -p build 

  cmake .. -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_SKIP_RPATH=ON \
        -DBUILD_TESTS=OFF \
        -DENABLE_SSE3=OFF \
        -DBUILD_EXAMPLES=ON \
        -DINSTALL_C_EXAMPLES=ON \
        -DINSTALL_PYTHON_EXAMPLES=ON \
        -DWITH_XINE=OFF \
        -DWITH_QT=ON \
        -DWITH_OPENGL=ON \
        -DWITH_TBB=OFF \
        -DWITH_CUDA=OFF \
        -DWITH_GTK=OFF \
        -DENABLE_FAST_MATH=ON \
        -DOPENCV_EXTRA_MODULES_PATH=${CACHE_PATH}/opencv_contrib-${_pkg_version}/modules
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}


