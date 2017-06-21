pkg_origin=cosmos

pkg_name=perl-file-next
_pkg_name=File-Next
pkg_version=1.16
pkg_description='File::Next - File-finding iterator'
pkg_license=('GPL' 'PerlArtistic')
pkg_upstream_url="http://search.cpan.org/dist/${_pkg_name}"
pkg_deps=('perl')
pkg_source=("http://search.cpan.org/CPAN/authors/id/P/PE/PETDANCE/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('103bc329cd2b64ec270ac53a7dacb378')

do_build() {
  ( export PERL_MM_USE_DEFAULT=1 PERL5LIB="" \
      PERL_AUTOINSTALL=--skipdeps            \
      PERL_MM_OPT="INSTALLDIRS=vendor"       \
      PERL_MB_OPT="--installdirs vendor"     \
      MODULEBUILDRC=/dev/null
      

    /usr/bin/perl Makefile.PL 
    make
  )
}

check() {
  
  ( export PERL_MM_USE_DEFAULT=1 PERL5LIB=""
    make test
  )
}

do_package() {
  make DESTDIR=${pkg_prefix} install 

  find ${pkg_prefix} -name perllocal.pod -delete
  find ${pkg_prefix} -name .packlist -delete
}
