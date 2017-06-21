pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=karchive
pkg_version=${_kf5ver}
pkg_description='Qt 5 addon providing access to numerous types of archives'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/karchive'
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'bzip2')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/unstable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
