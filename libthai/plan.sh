pkg_origin=cosmos

pkg_name=libthai
pkg_version=0.1.26
pkg_description="Thai language support routines"
pkg_upstream_url="https://linux.thai.net/projects/libthai"
pkg_license=('LGPL')
pkg_deps=('libdatrie')
pkg_build_deps=('pkgconfig')
pkg_source=("https://linux.thai.net/pub/thailinux/software/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('e79403961d538b56fc4af7670643844c')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

