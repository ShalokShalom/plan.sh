pkg_origin=cosmos

pkg_name=jansson
pkg_version=2.10
pkg_description='C library for encoding, decoding and manipulating JSON data'
pkg_upstream_url='http://www.digip.org/jansson/'
pkg_license=('MIT')
pkg_source=("http://www.digip.org/jansson/releases/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('8f85f653fba3ac8220ad8f2f47646ef1')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
