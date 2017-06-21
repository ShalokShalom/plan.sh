pkg_origin=

pkg_name=kdev-python
pkg_version=5.1.1
_pkg_version=5.1.1
pkg_description='KDevelop plugin which provides Python language support.'
pkg_upstream_url="https://projects.kde.org/projects/extragear/kdevelop/plugins/kdev-python"
pkg_license=('GPL')
pkg_deps=('kdevelop' 'python3' 'ki18n' 'knewstuff' 'kitemmodels' 'threadweaver'
         'ktexteditor' 'kcmutils')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'kdevelop-pg-qt')
pkg_source=("http://download.kde.org/stable/kdevelop/${_pkg_version}/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('d8ade92b4c6af07b9724b1e47b0d6bd5')

do_build() {
  mkdir -p build  
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
