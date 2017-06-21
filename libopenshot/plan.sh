pkg_origin=

pkg_name=libopenshot
pkg_version=0.1.7
pkg_description="Open-source project dedicated to delivering high quality video editing, animation, and playback solutions to the world."
pkg_upstream_url="http://www.openshot.org/"
pkg_license=('LGPL3')
pkg_deps=('libopenshot-audio' 'ffmpeg' 'imagemagick' 'libx11' 'libxcursor' 'libxinerama' 'python3'
         'ruby' 'x264' 'qt5-multimedia' 'zeromq')
pkg_build_deps=('cmake' 'swig' 'doxygen')
# http://bazaar.launchpad.net/~openshot.code/libopenshot/trunk/files
pkg_source=("https://launchpad.net/libopenshot/0.1/$pkg_version/+download/libopenshot-$pkg_version.tar.gz")
pkg_shasum=('5a0b7c681d7c437ce4a73752cfa4e3ca')

prepare () {
  #cd ${pkg_name}-${pkg_version}
  
  sed -i 's|add_subdirectory(tests)|#add_subdirectory(tests)|' CMakeLists.txt
}   

do_build() {
  mkdir -p build
  cd build
  
  cmake ../ \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DMAGICKCORE_HDRI_ENABLE=1 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  # install the example and simple player
  install -d ${pkg_prefix}/usr/bin
  install -m755 src/openshot-* ${pkg_prefix}/usr/bin
}
