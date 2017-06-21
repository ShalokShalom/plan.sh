pkg_origin=cosmos

pkg_name=libwpd
pkg_version=0.10.1
pkg_description="Library for importing WordPerfect (tm) documents"
pkg_upstream_url="http://libwpd.sourceforge.net/"
pkg_license=('LGPL')
pkg_deps=('gcc-libs' 'librevenge')
pkg_build_deps=('libgsf>=1.14.20')
pkg_source=("http://sourceforge.net/projects/libwpd/files/libwpd/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('2e98574901f8019a239947c1d8c34b69')

do_build() {
  
  ./configure --prefix=/usr --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
