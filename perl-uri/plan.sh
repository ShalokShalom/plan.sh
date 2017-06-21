pkg_origin=cosmos

pkg_name=perl-uri
pkg_version=1.71
pkg_description="Uniform Resource Identifiers (absolute and relative)"
pkg_upstream_url="http://search.cpan.org/dist/URI/"
pkg_license=('PerlArtistic')
pkg_deps=('perl')
pkg_source=("http://cpan.metacpan.org/authors/id/E/ET/ETHER/URI-${pkg_version}.tar.gz")
pkg_shasum=('247c3da29a794f72730e01aa5a715daf')

do_build() {

  perl Makefile.PL INSTALLDIRS=vendor
  make
}

check() {

  make test
}

do_package() {
  
  make install DESTDIR=${pkg_prefix}
}
