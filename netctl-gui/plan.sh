pkg_origin=

pkg_name=netctl-gui
pkg_version=1.4.9
pkg_description="Qt5 graphical interface for netctl, including a widget"
pkg_upstream_url="https://arcanis.me/projects/netctl-gui/"
pkg_license=('GPL3')
pkg_deps=('plasma-framework' 'netctl' 'wpa_supplicant')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
install=netctl-gui.install
pkg_source=("https://github.com/arcan1s/netctl-gui/releases/download/V.${pkg_version}/${pkg_name}-${pkg_version}-src.tar.xz")
#pkg_source=("git://github.com/arcan1s/netctl-gui")
pkg_shasum=('64c04c36eea017e7c0ddf687d60de128')

do_prepare() {
  cd ${pkg_name}
  
  #git submodule init
  #git submodule update
  
  #sed -i 's|WPACLI_PATH=/usr/bin/wpa_cli|WPACLI_PATH=/usr/sbin/wpa_cli|' ${CACHE_PATH}/${pkg_name}/helper/netctl-gui.conf
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_GUI:BOOL=1 \
    -DBUILD_LIBRARY:BOOL=1 \
    -DBUILD_HELPER:BOOL=1 \
    -DBUILD_DATAENGINE:BOOL=1 \
    -DBUILD_PLASMOID:BOOL=1 \
    -DUSE_CAPABILITIES:BOOL=1 
  make
}


do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

