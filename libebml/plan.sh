pkg_origin=cosmos

pkg_name=libebml
pkg_version=1.3.4
pkg_description="Extensible Binary Meta Language library"
pkg_upstream_url="http://dl.matroska.org/downloads/libebml/"
pkg_license=('LGPL')
pkg_deps=('gcc-libs')
pkg_source=("http://dl.matroska.org/downloads/libebml/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('58c848f85127032f23ab47b672484f45')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {

  make prefix=${pkg_prefix}/usr install
}
