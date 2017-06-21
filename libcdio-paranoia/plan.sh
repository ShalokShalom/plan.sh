pkg_origin=cosmos

pkg_name=libcdio-paranoia
pkg_version=10.2.2
_pkg_version=10.2+0.94+1
pkg_description="CD paranoia libraries from libcdio"
pkg_license=('GPL' 'LGPL')
pkg_upstream_url="https://www.gnu.org/software/libcdio/"
pkg_deps=('libcdio')
pkg_source=("http://ftp.gnu.org/gnu/libcdio/${pkg_name}-${_pkg_version}.tar.bz2")
pkg_shasum=('1e8f35be7fff7e0658063ae019ce3b6e')

do_build() {

  ./configure --prefix=/usr \
        --enable-cpp-progs \
        --disable-static \
        --disable-example-progs
  make
}

do_package() {

  make -j1 DESTDIR=${pkg_prefix} install
}
