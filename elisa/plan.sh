pkg_origin=

pkg_name=elisa
pkg_version=0.0.3
_commit=215f626cc6c4ff64cd6759339a43d37f5e0164f4
pkg_description="Music Player"
pkg_upstream_url="https://github.com/KDE/elisa"
pkg_license=('GPL')
pkg_deps=('ki18n' 'kdeclarative' 'kcoreaddons' 'baloo' 'kfilemetadata' 'kxmlgui' 
         'kconfigwidgets' 'kconfig' 'qt5-quickcontrols' 'qt5-quickcontrols2' 
         'qt5-websockets' 'kdsoap') # 'upnp-qt')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://github.com/KDE/elisa/archive/${_commit}.zip")
pkg_shasum=('5cba7b72893483c2cf3630521fe4f93a')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib
    
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
