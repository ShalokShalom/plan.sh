pkg_origin=

pkg_name=powertop
pkg_version=2.9
pkg_description="Tool that finds the software that makes your laptop use more power than necessary"
pkg_upstream_url="https://01.org/powertop/"
pkg_license=('GPL2')
pkg_deps=('gcc-libs' 'libnl' 'ncurses' 'pciutils')
pkg_source=("https://github.com/fenrus75/powertop/archive/v$pkg_version.tar.gz")
pkg_shasum=('517a3d6fc3d069b9f1d080a93cf51018')

do_build() {
  cd ${CACHE_PATH}/powertop-$pkg_version

  ./autogen.sh
  ./configure --prefix=/usr 
  make 
}

do_package() {
  cd ${CACHE_PATH}/powertop-$pkg_version

  make DESTDIR=${pkg_prefix} install
}
