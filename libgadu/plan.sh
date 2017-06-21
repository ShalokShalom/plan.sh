pkg_origin=cosmos

pkg_name=libgadu
pkg_version=1.12.2
pkg_description="This library implements the client side of the Gadu-Gadu protocol"
pkg_upstream_url="http://libgadu.net/"
pkg_license=('GPL')
pkg_deps=('gnutls' 'zlib' 'protobuf-c')
pkg_source=("https://github.com/wojtekka/libgadu/archive/${pkg_version}.tar.gz")
pkg_shasum=('1eecae8245d696adfbcfd40a2b36f0ca')

do_build() {
  
  ./autogen.sh
  ./configure --prefix=/usr \
    --disable-static \
    --enable-shared \
    --with-pthread
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
