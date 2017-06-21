pkg_origin=

pkg_name=libktorrent
pkg_version=2.0.1
ktorver=5.0
pkg_description="A BitTorrent program for KDE"
pkg_upstream_url="http://ktorrent.pwsp.net/"
pkg_license=('GPL2')
pkg_deps=('karchive' 'kcrash' 'ki18n' 'kio' 'solid' 'qca-qt5')
pkg_build_deps=('extra-cmake-modules' 'boost' 'doxygen' 'kdoctools')
pkg_source=("http://download.kde.org/stable/ktorrent/${ktorver}/${pkg_name}-${pkg_version}.tar.xz")
#pkg_source=('git://anongit.kde.org/libktorrent')
pkg_shasum=('4b2e0fab4e9d45a96ee5b2526d4f1945')

do_build() {
  cd ${CACHE_PATH}
  mkdir build
  
  cd build
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON 
  make
}

do_package() {
  cd ${CACHE_PATH}/build
  
  make DESTDIR=${pkg_prefix} install
}
