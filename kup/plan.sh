pkg_origin=

pkg_name=kup
pkg_version=0.7.0
pkg_description="Kup is created for helping people to keep up-to-date backups of their personal files."
pkg_upstream_url="https://github.com/spersson/Kup"
pkg_license=('GPL')
pkg_deps=('solid' 'kio' 'kidletime' 'ki18n' 'knotifications' 'kcoreaddons' 'kiconthemes'
         'kdbusaddons' 'kconfig' 'kinit' 'plasma-framework')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://github.com/spersson/Kup/archive/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('91d5879a1282a8e0e8898ae6f2c3ecbe')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../Kup-${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
