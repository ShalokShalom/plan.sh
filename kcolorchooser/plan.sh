pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kcolorchooser
pkg_version=${_kdever}
#pkg_version=15.11.80
pkg_description="Color Chooser"
pkg_upstream_url="http://kde.org/applications/graphics/kcolorchooser/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('ki18n' 'kwidgetsaddons' 'kxmlgui')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/kcolorchooser.git")
#pkg_shasum=('SKIP')


do_build() {
  mkdir build  
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
