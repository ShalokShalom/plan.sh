pkg_origin=cosmos

pkg_name=perl-locale-gettext
_pkg_name=gettext
pkg_version=1.05
pkg_description="Permits access from Perl to the gettext() family of functions"
pkg_license=('GPL' 'PerlArtistic')
pkg_upstream_url="http://search.cpan.org/dist/${_pkg_name}/"
pkg_deps=('gettext' 'perl')
pkg_source=("http://search.cpan.org/CPAN/authors/id/P/PV/PVANDRY/${_pkg_name}-${pkg_version}.tar.gz"
        'compatibility-with-POSIX-module.patch')
pkg_shasum=('f3d3f474a1458f37174c410dfef61a46'
         '854302f34d01a2f8ae739187788973dd')

do_build() {
  cd ${_pkg_name}-${pkg_version}

  patch -p1 -i ${CACHE_PATH}/compatibility-with-POSIX-module.patch
  # install module in vendor directories.
  PERL_MM_USE_DEFAULT=1 perl Makefile.PL INSTALLDIRS=vendor
  make
}

do_check() {
  cd ${_pkg_name}-${pkg_version}
  
  make test
}

do_package() {
  cd ${_pkg_name}-${pkg_version}
  make install DESTDIR=${pkg_prefix}

  # remove perllocal.pod and .packlist
  find ${pkg_prefix} -name perllocal.pod -delete
  find ${pkg_prefix} -name .packlist -delete
}
