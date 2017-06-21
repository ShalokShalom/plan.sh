pkg_origin=

pkg_name=systemd-kcm
pkg_version=1.2.1
pkg_description="Systemd control module for KDE"
pkg_upstream_url='https://github.com/KDE/systemd-kcm'
pkg_license=('GPL')
pkg_deps=('kconfigwidgets' 'kcoreaddons' 'kwidgetsaddons' 'ki18n' 'kio' 'kservice' 'kauth' 'boost-libs')
pkg_build_deps=('extra-cmake-modules' 'boost')
pkg_source=("https://download.kde.org/stable/systemd-kcm/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('9081233ce9bb356eaacc5ab247c6dbb2')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  sed -i -e 's|system-administration|session|' ${pkg_prefix}/usr/share/kservices5/kcm_systemd.desktop
  rm ${pkg_prefix}/usr/share/kservices5/settings-system-administration.desktop
}
