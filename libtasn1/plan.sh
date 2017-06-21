pkg_origin=cosmos

pkg_name=libtasn1
pkg_version=4.12
pkg_description="The ASN.1 library used in GNUTLS"
pkg_license=('GPL3' 'LGPL')
pkg_upstream_url="https://www.gnu.org/software/libtasn1/"
pkg_deps=('glibc' 'texinfo')
checkpkg_deps=('valgrind')
pkg_source=("https://ftp.gnu.org/gnu/libtasn1/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('5c724bd1f73aaf4a311833e1cd297b21')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr \
      --with-packager=KaOS \
      --with-packager-bug-reports="https://github.com/KaOSx/core/issues" \
      --with-packager-version=${pkg_version}-${pkgrel}
  make
}

do_check() {
  cd ${pkg_name}-${pkg_version}
  
  make check
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
