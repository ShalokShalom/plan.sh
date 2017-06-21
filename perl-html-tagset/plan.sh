pkg_origin=cosmos

pkg_name=perl-html-tagset
_pkg_name=HTML-Tagset
pkg_version=3.20
pkg_description="Data tables useful in parsing HTML"
pkg_license=('PerlArtistic')
pkg_upstream_url="http://search.cpan.org/dist/${_pkg_name}/"
pkg_deps=('perl')
pkg_source=("http://www.cpan.org/authors/id/P/PE/PETDANCE/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('d2bfa18fe1904df7f683e96611e87437')

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
