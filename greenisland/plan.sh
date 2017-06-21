pkg_origin=

pkg_name=greenisland
pkg_version=0.9.0.1
_commit=088b657a26d5f909bfe42fd7b5fec4d96265afe9
pkg_upstream_url='https://github.com/greenisland/greenisland'
pkg_description="Wayland compositor for QtQuick as well as pluggable hardware abstraction, extensions and tools Wayland clients."
pkg_license=('LGPL')
pkg_deps=('fontconfig' 'freetype2' 'libdrm' 'libinput' 'libxcomposite' 'libxkbcommon' 'qt5-declarative'
         'systemd' 'wayland-protocols' 'xkeyboard-config' 'xcb-util-cursor')
pkg_build_deps=('extra-cmake-modules' 'gdb')
pkg_source=("https://github.com/greenisland/greenisland/archive/${_commit}.zip") 
pkg_shasum=('f071e3d9cc4ed1abb45e90e9a84b3e7c')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_QMLDIR=lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
