pkg_origin=

pkg_name=mediainfo
_pkg_name=MediaInfo
pkg_version=0.7.96
pkg_description="Convenient unified display of the most relevant technical and tag data for video and audio files."
pkg_upstream_url="https://github.com/MediaArea/MediaInfo"
pkg_license=('GPL')
pkg_deps=('mediainfolib' 'qt5-base')
pkg_build_deps=('libtool')
pkg_source=("https://github.com/MediaArea/MediaInfo/archive/v${pkg_version}.tar.gz"
        'mediainfo-qt5.patch')
pkg_shasum=('26a4a952a506ce31a593688ab60bf186'
         '87c3909289a1e9c11711e6a75ea42ab8')

do_prepare() {
  cd ${_pkg_name}-${pkg_version}
  
  # patch from crazy, frugalware developer
  patch -p1 -i ${CACHE_PATH}/mediainfo-qt5.patch
  sed -i 's|Exec=mediainfo-gui %f|Exec=mediainfo-qt5-gui|' Project/GNU/GUI/mediainfo-gui.desktop
}

do_build() {
  cd ${_pkg_name}-${pkg_version}/Project/GNU/CLI
  
  ./autogen.sh
  ./configure --prefix=/usr
  make
  
  cd ${CACHE_PATH}/${_pkg_name}-${pkg_version}/Project/QMake/GUI
  
  /usr/lib/qt5/bin/qmake
  make
}

do_package() {
  cd ${_pkg_name}-${pkg_version}/Project/GNU/CLI
  make DESTDIR=${pkg_prefix} install
  
  install -D -m755 ${CACHE_PATH}/${_pkg_name}-${pkg_version}/Project/QMake/GUI/mediainfo-qt5-gui \
    ${pkg_prefix}/usr/bin/mediainfo-qt5-gui
  install -D -m644 ${CACHE_PATH}/${_pkg_name}-${pkg_version}/Project/GNU/GUI/mediainfo-gui.desktop \
    ${pkg_prefix}/usr/share/applications/mediainfo-gui.desktop
  install -Dm 644 ${CACHE_PATH}/${_pkg_name}-${pkg_version}/Source/Resource/Image/MediaInfo.svg \
    ${pkg_prefix}/usr/share/icons/hicolor/scalable/apps/mediainfo.svg
}
