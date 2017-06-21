pkg_origin=cosmos

pkg_name=libodfgen
pkg_version=0.1.6
pkg_description="Library for generating documents in Open Document Format (ODF)."
pkg_upstream_url="http://sf.net/p/libwpd/libodfgen/"
pkg_license=('MPL2')
pkg_deps=('libwpd' 'libwpg' 'libetonyek' 'libxml2' 'gperf' 'zlib' 'librevenge') 
pkg_build_deps=('boost')
pkg_source=("http://sourceforge.net/projects/libwpd/files/libodfgen/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('731fd5e5513c55ed64458a0a8c33a830')

do_build() {

  ./autogen.sh
  ./configure --without-docs --enable-static=no --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
