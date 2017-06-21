pkg_origin=

pkg_name=keepassxc
pkg_version=2.1.4
_commit=d4ed4f93255e51ed7a7986e6040f240ac6488670
pkg_description="Cross-platform community-driven port of the Windows application Keepass Password Safe"
pkg_upstream_url="http://www.keepassxc.org/"
pkg_license=('GPL2')
pkg_deps=('qt5-x11extras' 'libxtst' 'shared-mime-info')
pkg_build_deps=('cmake' 'intltool' 'qt5-tools')
#pkg_source=("https://www.keepassx.org/releases/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_source=("https://github.com/keepassxreboot/keepassxc/releases/download/${pkg_version}/${pkg_name}-${pkg_version}-src.tar.xz")
pkg_shasum=('f2314e36735d4d2c490a1888bd0fc31e')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=/usr/lib \
    -DWITH_GUI_TESTS=OFF \
    -DWITH_XC_HTTP=ON \
    -DWITH_XC_AUTOTYPE=ON
  make 
}

do_check() {
    cd build
    # testguipixmaps & testgui fail with GUI_TESTS
    make test
}

do_package() {
    cd build
    
    make DESTDIR=${pkg_prefix} install 
}
