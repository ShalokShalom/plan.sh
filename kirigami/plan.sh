pkg_origin=
 
pkg_name=kirigami
pkg_version=2.2.0
pkg_description='Set of QtQuick components at the moment targeted for mobile use (in the future desktop as well)'
pkg_upstream_url='https://github.com/KDE/kirigami'
pkg_license=('LGPL')
pkg_deps=('plasma-framework' 'purpose' 'qt5-svg' 'qt5-quickcontrols2')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("https://download.kde.org/stable/kirigami/${pkg_name}2-${pkg_version}.tar.xz")
pkg_shasum=('0de054842076b67f6745c92764c284cd')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}2-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DBUILD_TESTING=OFF
    
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
