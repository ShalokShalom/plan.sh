pkg_origin=

pkg_name=fcitx
pkg_version=4.2.9.1
pkg_description="A Flexible Input Method Framework"
pkg_license=('GPL')
pkg_upstream_url="https://github.com/fcitx/"
pkg_deps=('pango' 'dbus' 'opencc' 'iso-codes' 'icu' 'libxkbfile' 'enchant' 'gettext'
         'shared-mime-info' 'hicolor-icon-theme' 'libxinerama' 'libxkbcommon')
pkg_build_deps=('extra-cmake-modules' 'doxygen' 'gobject-introspection')
install=fcitx.install
pkg_source=("http://download.fcitx-im.org/${pkg_name}/${pkg_name}-${pkg_version}_dict.tar.xz")
pkg_shasum=('9b566df835413a7aa964488c5b0c60d8')

do_build() { 
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release \
      -DSYSCONFDIR=/etc \
      -DENABLE_QT=Off \
      -DENABLE_GTK2_IM_MODULE=Off \
      -DENABLE_GTK3_IM_MODULE=Off \
      -DENABLE_OPENCC=On \
      -DENABLE_GIR=Off
  make
}

do_package(){
    cd build
    
    make DESTDIR=${pkg_prefix} install
}

