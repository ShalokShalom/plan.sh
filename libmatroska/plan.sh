pkg_origin=cosmos

pkg_name=libmatroska
pkg_version=1.4.7
pkg_description="C++ libary to parse Matroska files"
pkg_upstream_url="https://www.matroska.org/"
pkg_license=('LGPL')
pkg_deps=('libebml')
pkg_source=("https://dl.matroska.org/downloads/libmatroska/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('45b583b5642d8e0a0c69f86dbf004eb7')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {

  make prefix=${pkg_prefix}/usr install
}
