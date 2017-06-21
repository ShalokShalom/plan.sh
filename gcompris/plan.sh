pkg_origin=

pkg_name=gcompris
pkg_version=0.70
_pkg_version=0.70
pkg_description="High quality educational software suite comprising of numerous activities for children aged 2 to 10."
pkg_upstream_url="http://gcompris.net/"
pkg_license=('GPL3')
pkg_deps=('qt5-multimedia' 'qt5-tools' 'qt5-declarative' 'qt5-svg' 'qt5-graphicaleffects' 'qt5-sensors'
         'qml-box2d')
pkg_build_deps=('texinfo' 'intltool' 'git' 'extra-cmake-modules' 'kdoctools' 'python2' 'qt5-tools')
pkg_source=("http://gcompris.net/download/qt/src/gcompris-qt-${pkg_version}.tar.xz"
        'gcompris.desktop'
        'gcompris.png'
        'https://github.com/KDE/gcompris/commit/e7f02d6282ec65a02347f2bd7b7103dceb3ccec0.diff'
        'https://github.com/KDE/gcompris/commit/5b46f5f96e77631ea871084bd54e68d834599442.diff')
pkg_shasum=('7ff70da4546f2db54bdc02cd76e4e4a1'
         '95b4bcb06168e38332d66fec1dda3aa2'
         '7c7cee3479f1a47376db800b2bc37017'
         '555abfce23e3c82853285ff93a3c6fb1'
         '1ea78f3db54fb148a93802f561dc5784')

do_prepare() {
  cd ${pkg_name}-qt-${pkg_version}
  #python2 tools/l10n-fetch-po-files.py
  #patch -R -p1 -i ${CACHE_PATH}/e7f02d6282ec65a02347f2bd7b7103dceb3ccec0.diff
  #patch -R -p1 -i ${CACHE_PATH}/5b46f5f96e77631ea871084bd54e68d834599442.diff
}
         
do_build() {
  mkdir build
  
  cd build 
  cmake ../${pkg_name}-qt-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DQML_BOX2D_MODULE=system \
    -DQML_BOX2D_LIBRARY=/usr/lib/qt5/qml/Box2D.2.0 \
    -DLRELEASE_EXECUTABLE=/usr/lib/qt5/bin/lrelease
  make 
  make BuildTranslations
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  #install -d "${pkg_prefix}/opt/$_pkg_name"
  #make package && ./"$_pkg_name-$_pkg_version"-Linux.sh --prefix="${pkg_prefix}"/opt/gcompris --skip-license
  
  #install -d "${pkg_prefix}/usr/bin"
  install -Dm644 ${CACHE_PATH}/gcompris.desktop ${pkg_prefix}/usr/share/applications/gcompris.desktop             
  install -Dm644 ${CACHE_PATH}/gcompris.png ${pkg_prefix}/usr/share/pixmaps/gcompris.png
  #ln -s /opt/gcompris/bin/ "$pkg_prefix/usr/bin/gcompris-qt"
}

