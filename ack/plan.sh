pkg_origin=

# do not build on server, perl issues
pkg_name=ack
pkg_version=2.18
pkg_description="A Perl-based grep replacement, aimed at programmers with large trees of heterogeneous source code"
pkg_upstream_url="http://betterthangrep.com/"
pkg_license=('GPL' 'PerlArtistic')
pkg_deps=('perl-file-next')
pkg_source=("http://search.cpan.org/CPAN/authors/id/P/PE/PETDANCE/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('c69da08ff819b2660e4ce3b1e1e8c390')

do_build() {
  cd ${pkg_name}-${pkg_version}
  PERL_MM_USE_DEFAULT=1 perl Makefile.PL INSTALLDIRS=vendor
  
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
}
