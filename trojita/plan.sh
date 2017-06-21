pkg_origin=

pkg_name=trojita
pkg_version=0.7
pkg_description="Trojita is a Qt IMAP e-mail client."
pkg_upstream_url="http://trojita.flaska.net"
pkg_license=('GPL')
pkg_deps=('qt5-webkit' 'qt5-tools' 'qtkeychain')
#pkg_deps=('qtwebkit')
#pkg_build_deps=('cmake' 'automoc4')
pkg_build_deps=('extra-cmake-modules' 'git')
pkg_source=("http://downloads.sourceforge.net/trojita/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('b2b5720be888ec6298a88798b113ad5f')
#pkg_source=('git://anongit.kde.org/trojita.git')
#pkg_shasum=('SKIP')


do_build() {
  cd ${pkg_name}-${pkg_version}
  sed -e "s|KF5Gpgmepp|QGpgme|" -i CMakeLists.txt
  sed -e "s|Cryptography KF5::Gpgmepp-pthread KF5::QGpgme|Cryptography QGpgme|" -i CMakeLists.txt
  
  mkdir -p build
  cd build
  
  cmake .. -DCMAKE_BUILD_TYPE=Release \
           -DCMAKE_INSTALL_PREFIX=/usr \
           -DWITH_QT5=ON
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}/build
  
  make DESTDIR=${pkg_prefix} install
}

