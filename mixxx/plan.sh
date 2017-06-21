pkg_origin=
pkg_name=mixxx
pkg_version=2.0.0
_pkg_version=release-2.0.0
pkg_description="Free, open source software for digital DJ'ing."
pkg_upstream_url='http://www.mixxx.org'
pkg_license=('GPL')
pkg_deps=('faad2' 'fftw' 'libid3tag' 'libmad' 'libmodplug' 'libogg' 'libshout' 'libsndfile' 'libusb' 
         'portaudio' 'portmidi' 'protobuf' 'qt5-svg' 'qt5-script' 'qtwebkit-tp' 'rubberband'
         'taglib' 'wavpack' 'opusfile' 'chromaprint')
pkg_build_deps=('scons' 'glu' 'qt5-tools')
pkg_source=("https://github.com/mixxxdj/mixxx/archive/${_pkg_version}.tar.gz"
        'chromaprint4.2.diff')
pkg_shasum=('784e9aafc133c6a31d13b32904d18d39'
         '7c8a70dfc7e463e4a34c654fad2c0e46')

do_build() {
  cd ${pkg_name}-${_pkg_version}
  # chromaprint 1.4.2 needed patch, from:
  # https://github.com/mixxxdj/mixxx/commit/5b252f36ce091d3a0d56afd10ad4085747c6708f
  patch -p1 -i ${CACHE_PATH}/chromaprint4.2.diff
  
  CXXFLAGS="-std=c++11"

  scons qtdir=/usr/lib/qt5 prefix=/usr faad=1 qt5=1 wv=1 modplug=1 opus=1
}

do_package() {
  cd ${pkg_name}-${_pkg_version}
  
  CXXFLAGS="-std=c++11"

  scons qtdir=/usr/lib/qt5 prefix=/usr qt5=1 install_root=${pkg_prefix}/usr install
}
