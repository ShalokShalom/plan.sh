pkg_origin=

pkg_name=plasma-applet-weather-widget
pkg_version=1.6.9
pkg_description="Plasmoid for Plasma 5. Shows weather information from yr.no server."
pkg_upstream_url="https://github.com/kotelnik/plasma-applet-weather-widget"
pkg_license=('GPL')
pkg_deps=('plasma-workspace')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://github.com/kotelnik/plasma-applet-weather-widget/archive/v${pkg_version}.tar.gz")
pkg_shasum=('f3a343e782b77023f3fd47d809fe49a5')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
