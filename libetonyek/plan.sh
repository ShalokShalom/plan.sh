pkg_origin=cosmos

pkg_name=libetonyek
pkg_version=0.1.6
pkg_description="Library and a set of tools for reading and converting Apple Keynote presentations."
pkg_upstream_url="https://wiki.documentfoundation.org/DLP/Libraries/libetonyek"
pkg_license=('MPL2')
pkg_deps=('libwpd' 'libxml2' 'gperf' 'zlib' 'librevenge' 'liblangtag')
pkg_build_deps=('boost' 'glm' 'cppunit' 'mdds')
pkg_source=("https://dev-www.libreoffice.org/src/libetonyek/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('dfe25b0c7739283a5c61a930ea1f9bf8')

do_build() {

  ./autogen.sh
  ./configure \
      --prefix=/usr \
      --disable-werror \
      --without-docs \
      --enable-static=no 
  make
}

check() {
  
  make check
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
