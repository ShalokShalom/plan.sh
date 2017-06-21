pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ktux
#pkg_version=${_kdever}
pkg_version=16.11.70
_commit=8b701fcedb85d7d7a668ee5df6caf35f09d49296
pkg_description='Screensaver of outer space, with Tux in a spaceship flying by.'
pkg_upstream_url='https://github.com/KDE/ktux'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'kcoreaddons')
pkg_build_deps=('extra-cmake-modules')
#pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
#pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
pkg_source=("https://github.com/KDE/ktux/archive/${_commit}.zip")
pkg_shasum=('6db6fad81d15fab6f2dc0d74e6e5ce0f')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
