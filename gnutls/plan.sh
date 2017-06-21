pkg_origin=cosmos

pkg_name=gnutls
pkg_version=3.5.13
_pkg_version=3.5.13
pkg_description="Secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them"
pkg_license=('GPL3' 'LGPL')
pkg_upstream_url="https://www.gnutls.org/"
pkg_deps=('gcc-libs' 'libtasn1' 'readline' 'zlib' 'texinfo' 'nettle' 'p11-kit')
makepends=('datefudge' 'valgrind' 'strace')
pkg_source=("https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('4fd41ad86572933c2379b4cc321a0959')

do_build() {
  cd ${pkg_name}-${_pkg_version}
  
  ./configure --prefix=/usr \
       --with-zlib \
       --disable-guile \
       --disable-static
  make 
}

do_check() {
  cd ${pkg_name}-${_pkg_version}
  
  make check
}

do_package() {
  cd ${pkg_name}-${_pkg_version}
  
  make DESTDIR=${pkg_prefix} install 
}

