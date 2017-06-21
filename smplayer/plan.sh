pkg_origin=

pkg_name=smplayer
pkg_version=17.6.0
_pkg_version=17.3.0
_rev=r6994
pkg_description="Media player with built-in codecs that can play virtually all video and audio formats"
pkg_upstream_url="http://smplayer.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('qt5-multimedia' 'qt5-script' 'mpv')
pkg_build_deps=('qt5-tools' 'subversion')
pkg_source=("https://sourceforge.net/projects/smplayer/files/SMPlayer/${pkg_version}/smplayer-${pkg_version}.tar.bz2"
        "https://sourceforge.net/projects/smplayer/files/SMPlayer-themes/${_pkg_version}/smplayer-themes-${_pkg_version}.tar.bz2"
        'icons.tar.xz'
        'default-theme.tar.xz')
pkg_shasum=('8f200fa8e440ecb07b96307435284dc6'
         '33c063c5a80c5b1625f51ddbb7bfd3a1'
         'a65b679cb82e21f8f67e703209654e8f'
         '7fda41dfcfca8ed9d57b5dabc931d845')

do_build() {
  cd ${pkg_name}-${pkg_version}
  rm -r icons
  rm -r src/default-theme
  mv -iv ${CACHE_PATH}/icons/ .
  mv -iv ${CACHE_PATH}/default-theme/ src/
  # don't use default h20, set to classic to use KaOS icon set
  sed -i -e 's|iconset = "H2O";|iconset = "";|' src/preferences.cpp
  sed -i -e 's|style = "Fusion";|style = "QtCurve";|' src/preferences.cpp
  
  make PREFIX=/usr QMAKE=/usr/lib/qt5/bin/qmake LRELEASE=/usr/lib/qt5/bin/lrelease
  
  DOC_PATH="\\\"/usr/share/doc/smplayer\\\"" QMAKE_OPTS=DEFINES+=NO_DEBUG_ON_CONSOLE
  
  cd ../smplayer-themes-${_pkg_version}/themes
  rcc-qt5 -binary Breeze.qrc -o Breeze/Breeze.rcc
  rcc-qt5 -binary Breeze-dark.qrc -o Breeze-dark/Breeze-dark.rcc
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DOC_PATH=/usr/share/doc/smplayer DESTDIR=${pkg_prefix} PREFIX=/usr install
  
  cd ../smplayer-themes-${_pkg_version}
  mkdir -p ${pkg_prefix}/usr/share/smplayer/themes/Breeze
  install -m 644 themes/Breeze/Breeze.rcc ${pkg_prefix}/usr/share/smplayer/themes/Breeze/
  install -m 644 themes/Breeze/README.txt ${pkg_prefix}/usr/share/smplayer/themes/Breeze/
  mkdir -p ${pkg_prefix}/usr/share/smplayer/themes/Breeze-dark
  install -m 644 themes/Breeze-dark/Breeze-dark.rcc ${pkg_prefix}/usr/share/smplayer/themes/Breeze-dark/
  install -m 644 themes/Breeze-dark/README.txt ${pkg_prefix}/usr/share/smplayer/themes/Breeze-dark/
}
