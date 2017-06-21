pkg_origin=

pkg_name=fcitx-qt5
pkg_version=1.1.0
pkg_description="QT5 IM Module for Fcitx"
pkg_upstream_url="http://code.google.com/p/fcitx"
pkg_license=('GPL')
pkg_deps=('fcitx' 'qt5-base')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://download.fcitx-im.org/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('5b2790d29a5b1a96a6e6b8aa9f8013ea')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib 
  make
}

do_package() {
  cd build
  
  make install DESTDIR=${pkg_prefix}
}

