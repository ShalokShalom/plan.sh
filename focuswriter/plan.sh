pkg_origin=

pkg_name=focuswriter
pkg_version=1.6.5
pkg_description="A simple fullscreen word processor."
pkg_upstream_url="https://gottcode.org/focuswriter/"
pkg_license=('GPL3')
pkg_deps=('enchant' 'libzip' 'qt5-declarative' 'sdl_mixer' 'qt5-multimedia' 'hunspell')
pkg_build_deps=('qt5-tools')
pkg_source=("https://gottcode.org/focuswriter/${pkg_name}-${pkg_version}-src.tar.bz2")
pkg_shasum=('bc244cc28cb8ceb3a15ee4fbe085db59')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  /usr/lib/qt5/bin/qmake PREFIX=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make INSTALL_ROOT=${pkg_prefix} install
}
