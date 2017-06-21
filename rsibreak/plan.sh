pkg_origin=

pkg_name=rsibreak
pkg_version=0.12.7
_pkg_version=0.12
pkg_description="RSIBreak helps in preventing Repetitive Strain Injury by reminding you to take a break."
pkg_upstream_url="https://userbase.kde.org/RSIBreak"
pkg_license=('GPL')
pkg_deps=('kconfig' 'kconfigwidgets' 'kcrash' 'kdbusaddons' 'kiconthemes' 'ki18n' 'kidletime'
         'knotifications' 'knotifyconfig' 'ktextwidgets' 'kxmlgui' 'kwindowsystem')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/rsibreak/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('9967888f3e3bd07d10d7503abcaa37d1')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
