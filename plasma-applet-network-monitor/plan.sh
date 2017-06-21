pkg_origin=

pkg_name=plasma-applet-network-monitor
pkg_version=1.7.3
pkg_description="Plasmoid that shows network speed of currently active connections."
pkg_upstream_url="https://github.com/kotelnik/plasma-applet-network-monitor"
pkg_license=('GPL')
pkg_deps=('plasma-framework')
pkg_build_deps=('extra-cmake-modules' 'git')
pkg_source=('git://github.com/kotelnik/plasma-applet-network-monitor.git')
pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DLIB_INSTALL_DIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
}

do_package() {
  cd build
  
  make install DESTDIR=${pkg_prefix}
}
