pkg_origin=

pkg_name=papyrus
pkg_version=1.0.1
_commit=5fde3c3b3c961ce33b03c11b6d3cb6fa60379527
pkg_description="Different note manager which is focusing on security and better user interface."
pkg_upstream_url="http://aseman.co/en/products/papyrus/"
pkg_license=('GPL3')
pkg_deps=('qt5-location' 'qt5-multimedia')
pkg_source=("https://github.com/Aseman-Land/Papyrus/archive/${_commit}.zip")
pkg_shasum=('4088a228159090b38037c6373479cbb3')

do_build() {
  mkdir -p build
  cd build

  /usr/lib/qt5/bin/qmake ../Papyrus-${_commit} PREFIX=/usr
  make
}

do_package() {
  cd build

  make INSTALL_ROOT=${pkg_prefix} install
}
