pkg_origin=

pkg_name=fcitx-gtk2
_pkg_name=fcitx
pkg_version=4.2.9.1
pkg_description="A Flexible Input Method Framework"
pkg_license=('GPL')
pkg_upstream_url="https://code.google.com/p/fcitx"
pkg_deps=('fcitx' 'gtk2')
pkg_build_deps=('extra-cmake-modules' 'doxygen' 'gobject-introspection')
install=${pkg_name}.install
pkg_source=("https://download.fcitx-im.org/$_pkg_name/$_pkg_name-${pkg_version}_dict.tar.xz")
pkg_shasum=('9b566df835413a7aa964488c5b0c60d8')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${_pkg_name}-${pkg_version} \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release \
      -DENABLE_QT=OFF
  make
}

do_package(){
    cd build/src/frontend/gtk2
    
    make DESTDIR=$pkg_prefix install
}

