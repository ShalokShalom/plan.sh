pkg_origin=

pkg_name=cutemarked
_pkg_name=CuteMarkEd
pkg_version=0.11.3
pkg_description="Qt-based, open source markdown editor with live HTML preview, math expressions and syntax highlighting."
pkg_upstream_url="https://github.com/cloose/CuteMarkEd"
pkg_license=('GPL2')
pkg_deps=('qt5-webkit' 'discount' 'hunspell')
pkg_build_deps=('qt5-tools')
pkg_source=("https://github.com/cloose/CuteMarkEd/archive/v$pkg_version.tar.gz")
pkg_shasum=('c8ec68d01e4afd337f9212f150e7351f')

do_build() {
  cd ${_pkg_name}-${pkg_version}

  /usr/lib/qt5/bin/qmake
  make 
}
do_package() {
  cd ${_pkg_name}-${pkg_version}
  
  make INSTALL_ROOT=${pkg_prefix} install
}
