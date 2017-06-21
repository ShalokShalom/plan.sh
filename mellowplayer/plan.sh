pkg_origin=

pkg_name=mellowplayer
pkg_version=2.2.5
_commit=50bdbf5
pkg_description="Open source and cross-platform desktop application that runs web-based music streaming 
         services in its own window and provides integration with your desktop, specifically crafted for KaOS"
pkg_upstream_url='https://colinduquesnoy.github.io/MellowPlayer/'
pkg_license=('GPL')
pkg_deps=('kglobalaccel' 'knotifications' 'qtwebengine' 'snorenotify' 'pepper-flash' 'widevine')
pkg_build_deps=('qt5-tools')
pkg_source=("https://github.com/ColinDuquesnoy/MellowPlayer/tarball/master/MellowPlayer-${pkg_version}.tar.gz")
pkg_shasum=('8b713ed264684d8b9bc20d0340bfc76a')

do_build() {
  cd ColinDuquesnoy-MellowPlayer-${_commit}

  /usr/lib/qt5/bin/qmake  CONFIG+=kde_support
  make 
}

do_package() {
  cd ColinDuquesnoy-MellowPlayer-${_commit}

  make INSTALL_ROOT=${pkg_prefix} install
}
