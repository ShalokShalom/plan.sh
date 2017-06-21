pkg_origin=cosmos

pkg_name=dotconf
pkg_version=1.3
pkg_description='C library for parsing configuration files'
pkg_upstream_url="https://github.com/williamh/dotconf"
pkg_license=('LGPL2.1')
pkg_deps=('glibc')
pkg_build_deps=('pkgconfig' 'findutils')
pkg_source=("https://github.com/williamh/dotconf/archive/v${pkg_version}.tar.gz")
pkg_shasum=('b3ba921e45b05e89bf69835c0f30bc14')

do_build() {
  
  autoreconf -i
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
