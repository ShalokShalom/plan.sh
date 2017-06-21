pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=extra-cmake-modules
pkg_version=${_kf5ver}
_pkg_version=5.17
pkg_description='Extra CMake modules'
pkg_upstream_url='https://github.com/KDE/extra-cmake-modules'
pkg_license=('LGPL')
pkg_deps=('cmake' 'python3')
pkg_build_deps=('qt5-tools') # python2-sphinx' 'sphinx_rtd_theme' 'alabaster' sphinx needs many more deps, disable)
pkg_source=("https://download.kde.org/stable/frameworks/${_pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
