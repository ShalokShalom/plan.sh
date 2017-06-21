pkg_origin=cosmos

pkg_name=opensp
pkg_version=1.5.2
pkg_description="A library and a set of tools for validating, parsing and manipulating SGML and XML documents"
pkg_upstream_url="http://openjade.sourceforge.net/"
pkg_license=('BSD')
pkg_deps=('gcc-libs')
pkg_build_deps=('xmlto' 'docbook-xsl')
pkg_source=("http://download.sourceforge.net/openjade/OpenSP-${pkg_version}.tar.gz")
pkg_shasum=('670b223c5d12cee40c9137be86b6c39b')

do_build() {
  
  ./configure --prefix=/usr \
    --mandir=/usr/share/man \
    --disable-nls \
    --enable-http \
    --enable-default-catalog=/etc/sgml/catalog:/etc/xml/catalog \
    --enable-default-search-path=/usr/share/sgml:/usr/share/xml \
    --enable-xml-messages
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE
}

