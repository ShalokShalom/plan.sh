pkg_origin=

pkg_name=babe
pkg_version=0.4.81
_commit=5ce66d9676abe778433302e4a8e0130a4c2c61ae
pkg_description="Babe will handle your whole music collection, letting you create custom playlists to organize your music."
pkg_upstream_url="https://milohr.github.io/BabeIt/"
pkg_license=('GPL3')
pkg_deps=('knotifications' 'ki18n' 'kconfig' 'qt5-multimedia' 'taglib' 'youtube-dl')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://github.com/KDE/babe/archive/${_commit}.zip"
        "https://github.com/KDE/babe/commit/77958ad9a49f0d28a532cda787f6874866c0fd4b.diff")
pkg_shasum=('93a6087b24bc855b9027b0cff8205cad'
         '2fe60a444879b9d2658d94199809a565')

do_prepare() {
  cd ${pkg_name}-${_commit}
  
  #sed -i -e 's|<qjson/parser.h>|<qjson-qt5/parser.h>|' artwork.cpp
  # restore menu icon
  #patch -R -p1 -i ${CACHE_PATH}/77958ad9a49f0d28a532cda787f6874866c0fd4b.diff
}

do_build() {
  #cd ${pkg_name}-${_commit}
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib
  #/usr/lib/qt5/bin/qmake Babe.pro
  make
}

do_package() {
  cd build
  #cd ${pkg_name}-${_commit}
  
  make DESTDIR=${pkg_prefix} install
  
  #install -D -m755 Babe ${pkg_prefix}/usr/bin/babe
  #install -D -m644 org.kde.babe.desktop ${pkg_prefix}/usr/share/applications/org.kde.babe.desktop
  install -D -m644 ../${pkg_name}-${_commit}/data/babe.svg ${pkg_prefix}/usr/share/icons/hicolor/scalable/apps/babe.svg
}
