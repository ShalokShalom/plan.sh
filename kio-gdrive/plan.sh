pkg_origin=

pkg_name=kio-gdrive
pkg_version=1.2.0.1
pkg_description="KIO Slave to access Google Drive"
pkg_upstream_url='https://github.com/KDE/kio-gdrive'
pkg_license=('GPL2')
pkg_deps=('ki18n' 'kio' 'libkgapi' 'qtkeychain' 'dolphin')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://download.kde.org/stable/kio-gdrive/${pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('ad8b1a70addcf4a5d218b7f90c4e2a46')

do_build() {
  mkdir -p build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
