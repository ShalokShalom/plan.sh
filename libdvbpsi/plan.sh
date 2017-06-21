pkg_origin=cosmos

pkg_name=libdvbpsi
pkg_version=1.3.1
pkg_description="A library designed for decoding and generation of MPEG TS and DVB PSI tables"
pkg_upstream_url="http://www.videolan.org/developers/libdvbpsi.html"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("http://download.videolan.org/pub/libdvbpsi/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('4e525af846c50742a1d3945b5d31f0a2')

do_build() {

  ./configure --prefix=/usr
  make
}

do_package() {
  
  make prefix=${pkg_prefix}/usr install
}

