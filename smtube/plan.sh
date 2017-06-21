pkg_origin=

pkg_name=smtube
pkg_version=17.5.0
_pkg_version=17.5.0
pkg_description="YouTube browser for smplayer, mplayer, vlc and dragonplayer"
pkg_upstream_url="http://smplayer.sourceforge.net"
pkg_license=('GPL')
pkg_deps=('qt5-base' 'qt5-webkit')
pkg_build_deps=('qt5-tools' 'qt5-script')
pkg_source=("https://sourceforge.net/projects/smtube/files/SMTube/${_pkg_version}/smtube-${_pkg_version}.tar.bz2")
pkg_shasum=('edfc9a47bb302b4af6089b152f815d15')

do_build() {
  cd ${pkg_name}-${_pkg_version}

  make PREFIX=/usr QMAKE=/usr/lib/qt5/bin/qmake LRELEASE=/usr/lib/qt5/bin/lrelease
}

do_package() {
  cd ${pkg_name}-${_pkg_version}

  make PREFIX=/usr DESTDIR=${pkg_prefix}/ install
}
