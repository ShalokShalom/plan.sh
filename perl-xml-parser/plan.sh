pkg_origin=cosmos

pkg_name=perl-xml-parser
_pkg_name=XML-Parser
pkg_version=2.44
pkg_description="Expat-based XML parser module for perl"
pkg_license=('GPL' 'PerlArtistic')
pkg_upstream_url="http://search.cpan.org/dist/${_pkg_name}/"
pkg_deps=('perl' 'expat')
pkg_source=("http://search.cpan.org/CPAN/authors/id/T/TO/TODDR/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('af4813fe3952362451201ced6fbce379')

do_build() {
  cd ${_pkg_name}-${pkg_version}

  perl Makefile.PL INSTALLDIRS=vendor
  make
}

do_check() {
  cd ${_pkg_name}-${pkg_version}
  
  make test
}

do_package() {
  cd ${_pkg_name}-${pkg_version}
  
  make install DESTDIR=${pkg_prefix}
}
