pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdegraphics-thumbnailers
pkg_version=${_kdever}
#pkg_version=15.07.70
pkg_description="Thumbnailers for various graphics file formats"
pkg_upstream_url="https://projects.kde.org/projects/kde/kdegraphics/kdegraphics-thumbnailers"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kio' 'libkexiv2' 'libkdcraw')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools' 'git')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/kdegraphics-thumbnailers.git#branch=frameworks")
#pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
