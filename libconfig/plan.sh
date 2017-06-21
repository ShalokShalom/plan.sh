pkg_origin=cosmos

pkg_name=libconfig
pkg_version=1.6
pkg_description="C/C++ library for processing configuration files"
pkg_upstream_url="http://hyperrealm.com/libconfig/libconfig.html"
pkg_license=('LGPL')
pkg_deps=('gcc-libs' 'texinfo')
pkg_source=("https://github.com/hyperrealm/libconfig/archive/v${pkg_version}.tar.gz")
pkg_shasum=('2ccd24b6a2ee39f7ff8a3badfafb6539')

do_build() {
  # build fix https://github.com/hyperrealm/libconfig/issues/53
  rm lib/scanner.c
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  rm ${pkg_prefix}/usr/share/info/dir
}
