pkg_origin=
 
pkg_name=user-kcm
pkg_version=1.0.3
pkg_description="KCM user modules"
pkg_upstream_url="https://github.com/KaOSx/user-kcm"
pkg_license=("GPL")
pkg_deps=('kitemmodels' 'kauth' 'kconfigwidgets' 'kcoreaddons' 'kcmutils'
         'knotifications' 'icu' 'xdg-utils')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools' 'git')
install=user-kcm.install
pkg_source=("git://github.com/KaOSx/user-kcm")
pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_SYSCONFDIR=/etc
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
