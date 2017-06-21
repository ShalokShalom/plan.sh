pkg_origin=

pkg_name=pacmanlogviewer
pkg_version=1.3.1
pkg_description="Inspect pacman log file."
pkg_upstream_url="https://opendesktop.org/content/show.php?content=150484"
pkg_license=('GPL')
pkg_deps=('qt5-base')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("https://dl.opendesktop.org/api/files/download/id/1466643430/150484-${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('da1bb1c4573b20dc4d2ff764a25c0479')
 
do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_WITH_QT5=ON
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
