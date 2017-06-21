pkg_origin=

pkg_name=clementine
_pkg_name=Clementine
pkg_version=1.3.1.1
_commit=03428b53c2cd59569860f5b831ee096a9e635131
pkg_description="Modern music player and library organiser that takes advantage of Qt."
pkg_upstream_url="http://www.clementine-player.org/"
pkg_license=('GPL')
pkg_deps=('gstreamer' 'taglib' 'glew' 'liblastfm' 'libgpod' 'libmtp' 'libplist'
         'hicolor-icon-theme' 'qtwebkit-tp' 'qt5-x11extras' 'libimobiledevice' 'protobuf'
         'libcdio-paranoia' 'qca-qt5' 'chromaprint' 'sparsehash' 
         'gst-plugins-bad' 'gst-plugins-good' 'gst-plugins-ugly' 'pulseaudio' 
         'libkvkontakte' 'crypto++' 'libmygpo-qt')
pkg_build_deps=('cmake' 'boost' 'mesa' 'qt5-tools')
#pkg_source=("https://github.com/clementine-player/${_pkg_name}/archive/${pkg_version}.tar.gz")
pkg_source=("https://github.com/clementine-player/Clementine/archive/${_commit}.zip"
        'tab_color.diff'
        'tokenizer.diff')
pkg_shasum=('f39160688da2f2f959aef33c31fd3505'
         '0d35b551ae875ca31037efa3601147f9'
         'baa891a12a4ed23846507644e3ad049f')

do_build() {
  cd ${_pkg_name}-${_commit}

  #sed -i 's|LASTFM5_LIBRARIES lastfm5|LASTFM5_LIBRARIES lastfm|g' ${CACHE_PATH}/clementine-player-${_pkg_name}-${_commit}/CMakeLists.txt
  sed -i 's|lastfm5/ws.h|lastfm/ws.h|g' ${CACHE_PATH}/${_pkg_name}-${_commit}/CMakeLists.txt
  sed -i 's|lastfm5/Track.h|lastfm/Track.h|g' ${CACHE_PATH}/${_pkg_name}-${_commit}/CMakeLists.txt
  sed -i 's|<lastfm5/|<lastfm/|g' ${CACHE_PATH}/${_pkg_name}-${_commit}/src/internet/lastfm/lastfmcompat.h
  sed -i 's|<lastfm5/|<lastfm/|g' ${CACHE_PATH}/${_pkg_name}-${_commit}/src/internet/lastfm/lastfmservice.cpp
  sed -i 's|<lastfm5/|<lastfm/|g' ${CACHE_PATH}/${_pkg_name}-${_commit}/src/internet/lastfm/lastfmsettingspage.cpp
  #sed -i 's|#include "internet/lastfm/fixlastfm.h"||g' ${CACHE_PATH}/clementine-player-${_pkg_name}-${_commit}/src/core/songloader.cpp
  sed -i 's|<lastfm5/Track.h>|<lastfm/Track.h>|g' ${CACHE_PATH}/${_pkg_name}-${_commit}/src/core/song.cpp
  
  sed -i 's|Exec=clementine %U|Exec=clementine|g' ${CACHE_PATH}/${_pkg_name}-${_commit}/dist/clementine.desktop
  
  patch -p1 -i ${CACHE_PATH}/tokenizer.diff
  
  mkdir -p build 
  
  cd build
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr \
            -DCMAKE_BUILD_TYPE=Release \
            -DENABLE_VK=ON 
  make
}

do_package() {
  cd ${_pkg_name}-${_commit}/build
  
  make install DESTDIR=${pkg_prefix}
}

