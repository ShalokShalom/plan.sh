pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kcharselect
pkg_version=${_kdever}
pkg_description="Tool to select special characters from all installed fonts and copy them into the clipboard."
pkg_upstream_url="https://projects.kde.org/projects/kde/kdeutils/kcharselect"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kbookmarks' 'ki18n' 'kwidgetsaddons' 'kxmlgui')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools')
pkg_source=($_mirror/${pkg_name}-$_kdever.tar.xz)
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version}  \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

