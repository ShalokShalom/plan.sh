pkg_origin=

pkg_name=kdeplasma-applets-menubar
pkg_version=0.2.0
pkg_description="Plasmoid to display menubar of application windows"
pkg_upstream_url="https://launchpad.net/plasma-widget-menubar"
pkg_license=('GPL')
pkg_deps=('kde-workspace' 'appmenu-qt' 'qjson')
pkg_build_deps=('cmake' 'automoc4')
pkg_source=("http://launchpad.net/plasma-widget-menubar/trunk/${pkg_version}/+download/plasma-widget-menubar-${pkg_version}.tar.bz2"
        "https://bugs.launchpad.net/plasma-widget-menubar/+bug/762865/+attachment/2111453/+files/fix_gtk_apps.diff")
pkg_shasum=('68852bf8612b9a1336fc2485b268445e'
         'e8f8f06f7f0b648027737c7759710ca4')

do_build() {
  mkdir build
  
  cd build
  cmake ../plasma-widget-menubar-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$(kde4-config --prefix)
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
