pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdesdk-strigi-analyzers
_pkg_name=kdesdk-strigi-analyzers
pkg_version=${_kdever}
pkg_description='Analyzer plugins for strigi'
pkg_upstream_url='https://projects.kde.org/projects/kde/kdesdk/kdesdk-strigi-analyzers'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kde-runtime')
pkg_build_deps=('cmake' 'automoc4')
pkg_source=("$_mirror/${_pkg_name}-$_kdever.tar.xz")
pkg_shasum=(`grep ${_pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
  mkdir build
  cd build
  
  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE4_BUILD_TESTS=OFF \
    -DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package() {
  cd build
  
  make DESTDIR=$pkg_prefix install
}
