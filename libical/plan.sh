pkg_origin=cosmos

pkg_name=libical
pkg_version=2.0.0
pkg_description="An Open Source implementation of the iCalendar protocols and protocol data units."
pkg_upstream_url='https://github.com/libical/libical'
pkg_license=('LGPL' 'MPL')
pkg_deps=('glibc' 'icu')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/libical/libical/archive/v${pkg_version}.tar.gz")
pkg_shasum=('ab743a66927284ccf42ee28847550144')

do_build() {

  mkdir -p build
  cmake .. \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  
  make install DESTDIR=${pkg_prefix}
}
