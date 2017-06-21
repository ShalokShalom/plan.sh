pkg_origin=

pkg_name=qtnote
pkg_version=3.0.3
_commit=cd7e69a
pkg_description="System tray app that allows you to make notes in a quick way, Qt clone of Tomboy."
pkg_upstream_url="http://ri0n.github.io/QtNote/"
pkg_license=('GPL3')
pkg_deps=('qt5-x11extras' 'hunspell')
pkg_source=("https://github.com/Ri0n/QtNote/archive/${pkg_version}.tar.gz")
pkg_shasum=('b12d0e7ea0d73c70a76a192c8dd6caed')

do_build() {
   cd QtNote-${pkg_version}/

   /usr/lib/qt5/bin/qmake 
   make
}

do_package() {
   cd QtNote-${pkg_version}/
   
   make INSTALL_ROOT=$pkg_prefix install
}
