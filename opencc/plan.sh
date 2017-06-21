pkg_origin=cosmos

pkg_name=opencc
_pkg_name=OpenCC-ver
pkg_version=1.0.5
pkg_upstream_url="https://github.com/BYVoid/OpenCC"
pkg_description="Library for Open Chinese Convert"
pkg_license=('Apache')
pkg_deps=('glibc')
pkg_build_deps=('cmake' 'doxygen' 'python2')
pkg_source=("https://github.com/BYVoid/OpenCC/archive/ver.${pkg_version}.tar.gz")
pkg_shasum=('229792990e669b4ebec119424371d65d')

do_build() {

  cmake -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_DOCUMENTATION:BOOL=ON
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
