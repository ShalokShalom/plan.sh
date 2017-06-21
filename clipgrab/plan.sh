pkg_origin=

pkg_name=clipgrab
pkg_version=3.6.5
_commit=e845692c23f6f8ce17c7bd6c1d779a97528da997
pkg_description='A friendly downloader for YouTube and other sites'
pkg_upstream_url='https://github.com/OpenHelios/clipgrab-qt5'
#pkg_upstream_url='http://clipgrab.org/'
pkg_license=('GPL3')
pkg_deps=('qtwebkit-tp' 'ffmpeg')
pkg_source=("https://github.com/OpenHelios/clipgrab-qt5/archive/${_commit}.zip"
        'clipgrab.desktop'
        'clipgrab.png'
        'video_vimeo.diff')
pkg_shasum=('a9afd2beb907d4c6d135506056d2d0f7'
         '9dd39ffcccb179d76ac84503bf3ffc11'
         'e427c3a49fe3f7a86abeaa443fcdbec3'
         '03c5d12ebb32b5f5daa59012cb70627e')

do_build() {
  cd ${pkg_name}-qt5-${_commit}
  patch -p1 -i ${CACHE_PATH}/video_vimeo.diff

  /usr/lib/qt5/bin/qmake clipgrab.pro
  make
}

do_package() {
  cd ${pkg_name}-qt5-${_commit}
  
  install -Dm755 ${pkg_name} ${pkg_prefix}/usr/bin/${pkg_name}
  install -Dm644 ../${pkg_name}.png ${pkg_prefix}/usr/share/pixmaps/${pkg_name}.png
  install -Dm644 ../${pkg_name}.desktop ${pkg_prefix}/usr/share/applications/${pkg_name}.desktop
}
