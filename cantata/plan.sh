pkg_origin=

pkg_name=cantata
pkg_version=2.0.1
_commit=d60f2973918f5ef50903297620777f9973e7ca22
pkg_description="A KDE client for the music player daemon (MPD)"
pkg_upstream_url="https://github.com/cdrummond/cantata"
pkg_license=('GPL')
pkg_deps=('qt5-multimedia' 'qt5-svg' 'libmtp' 'libcddb' 'libmusicbrainz5'
         'mpg123' 'taglib-extras' 'mpd' 'media-player-info' 'udisks2')
pkg_build_deps=('cmake' 'qt5-tools')
#pkg_source=("https://github.com/CDrummond/cantata/archive/${_commit}.zip")
pkg_source=("https://github.com/CDrummond/cantata/releases/download/v${pkg_version}/cantata-${pkg_version}.tar.bz2")
pkg_shasum=('dacab1b6bf7639e3d46876db8883fbb2')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #sed -i -e 's|basic->setChecked(false);|basic->setChecked(true);|' gui/initialsettingswizard.cpp
  #sed -i -e 's|advanced->setChecked(true);|advanced->setChecked(false);|' gui/initialsettingswizard.cpp
}

do_build() {
  mkdir build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DENABLE_HTTP_STREAM_PLAYBACK=ON \
    -DENABLE_LIBVLC=OFF \
    -DENABLE_KDE=OFF \
    -DENABLE_QT5=ON \
    -DENABLE_TOUCH_SUPPORT=ON \
    -DENABLE_SIMPLE_MPD_SUPPORT=ON \
    -DLCONVERT_EXECUTABLE=/usr/lib/qt5/bin/lconvert \
    -DLRELEASE_EXECUTABLE=/usr/lib/qt5/bin/lrelease
  make
}

do_package() {
  cd build
  
  make DESTDIR="$pkg_prefix" PREFIX="/usr" install
}
