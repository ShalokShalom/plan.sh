pkg_origin=

pkg_name=snorenotify
pkg_version=0.7.0
pkg_description="Multi platform Qt based notification framework."
pkg_upstream_url="https://github.com/TheOneRing/Snorenotify"
pkg_license=('LGPL-3')
pkg_deps=('qt5-declarative' 'qt5-multimedia')
pkg_build_deps=('extra-cmake-modules' 'boost' 'qt5-tools')
pkg_source=("http://download.kde.org/stable/snorenotify/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('b5787bf7aaac4700144bba29df5a89ab')
         
do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DLIBSNORE_PLUGIN_PATH=/usr/lib/libsnore-qt5 \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
