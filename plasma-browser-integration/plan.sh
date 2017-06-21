pkg_origin=

pkg_name=plasma-browser-integration
pkg_version=0.0.3
_commit=08a78f12948600c439729d4e44e497b1d952f303
pkg_description="Plasma5 browser integration"
pkg_upstream_url="https://github.com/KDE/plasma-browser-integration"
pkg_license=('GPL')
pkg_deps=('kio' 'ki18n' 'knotifications' 'krunner' 'kwindowsystem' 'kactivities')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://github.com/KDE/plasma-browser-integration/archive/${_commit}.zip")
pkg_shasum=('7302ec7ec8865cce26def3f6d21adb02')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib \
    -DINSTALL_CHROME_EXTENSION=ON
    
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
