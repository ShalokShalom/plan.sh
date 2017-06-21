pkg_origin=cosmos

pkg_name=v4l-utils
pkg_version=1.12.5
pkg_description="Userspace tools and conversion library for Video 4 Linux"
pkg_upstream_url="http://freshmeat.net/projects/libv4l"
pkg_license=('LGPL')
pkg_deps=('glibc' 'gcc-libs' 'sysfsutils' 'libjpeg-turbo') # 'qt5-base')
pkg_source=("http://linuxtv.org/downloads/v4l-utils/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('98ade56409bb1beb665c9cf2e4d99592')

do_build() {

  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  MAKEFLAGS="-j1" make install DESTDIR=${CACHE_PATH}/
  
  rm -f ${CACHE_PATH}/usr/bin/ivtv-ctl
}
