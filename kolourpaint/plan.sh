pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kolourpaint
pkg_version=${_kdever}
#pkg_version=16.03.71
_commit=6c8d56fc966311468c13bcc855c8fffbf5240394
pkg_description="Painting program to quickly create raster images plus useful as a touch-up tool and simple image editing tasks."
pkg_upstream_url="http://kde.org/applications/graphics/kolourpaint/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kparts' 'kdelibs4support' 'libkexiv2' 'libksane')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("https://github.com/KDE/kolourpaint/archive/${_commit}.zip")
#pkg_shasum=('c3a9547479929e4f3db29eb7d2946185')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
