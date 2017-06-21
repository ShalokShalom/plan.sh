pkg_origin=

pkg_name=lftp
pkg_version=4.7.7
_pkg_version=4.7.7
pkg_description="Sophisticated command line based FTP client with openssl"
pkg_upstream_url="https://lftp.yar.ru/"
pkg_license=('GPL3')
pkg_deps=('gcc-libs' 'readline' 'gnutls' 'expat' 'perl' 'sh')
pkg_build_deps=('autoconf')
categories=('network')
pkg_source=("https://lftp.yar.ru/ftp/${pkg_name}-${_pkg_version}.tar.xz")
pkg_shasum=('1e84dd802bdd4d1be15b8dac9fc9c697')

do_build() {
  cd ${pkg_name}-${_pkg_version}
  
  ./configure --prefix=/usr \
        --with-gnutls \
        --without-included-regex \
        --without-openssl \
        --disable-static
  make
}

do_package() {
  cd ${pkg_name}-${_pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  rm -rf ${pkg_prefix}/usr/lib
}
