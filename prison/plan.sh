pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=prison
pkg_version=${_kf5ver}
pkg_description="A barcode api to produce QRCode barcodes and DataMatrix barcode"
pkg_upstream_url="https://github.com/KDE/prison"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('qt5-base' 'libdmtx' 'qrencode')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/frameworks/5.29/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON   
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
  
  cd ${pkg_prefix}/usr/lib/
  ln -s libKF5Prison.so.5 libKF5Prison.so.1
}

