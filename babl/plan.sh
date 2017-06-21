pkg_origin=cosmos

pkg_name=babl
pkg_version=0.1.28
_pkg_version=0.1
pkg_description="Dynamic, any to any, pixel format conversion library"
pkg_upstream_url="http://gegl.org/babl/"
pkg_license=('LGPL3')
pkg_deps=('glibc')
pkg_source=("https://ftp.gimp.org/pub/babl/${_pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('cc53d8474a43aafb7cdaccea56cfde44')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
