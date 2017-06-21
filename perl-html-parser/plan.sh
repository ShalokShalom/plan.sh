pkg_origin=cosmos

pkg_name=perl-html-parser
_pkg_name=HTML-Parser
pkg_version=3.72
pkg_description="Perl HTML parser class"
pkg_license=('PerlArtistic')
pkg_upstream_url="http://search.cpan.org/dist/${_pkg_name}/"
pkg_deps=('perl-html-tagset' 'perl')
checkpkg_deps=('perl-test-pod')
pkg_source=("http://www.cpan.org/authors/id/G/GA/GAAS/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('eb7505e5f626913350df9dd4a03d54a8')

do_build() {
  
  # install module in vendor directories.
  perl Makefile.PL INSTALLDIRS=vendor
  make
}

check() {
  
  make test
}

do_package() {
  
  make install DESTDIR=${pkg_prefix}
}
