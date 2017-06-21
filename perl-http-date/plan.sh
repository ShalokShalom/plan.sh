pkg_origin=cosmos

pkg_name=perl-http-date
pkg_version=6.02
pkg_description="date conversion routines"
pkg_upstream_url="http://search.cpan.org/dist/HTTP-Date"
pkg_license=('PerlArtistic' 'GPL')
pkg_deps=('perl')
pkg_source=("http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/HTTP-Date-${pkg_version}.tar.gz")
pkg_shasum=('52b7a0d5982d61be1edb217751d7daba')

do_build() {
    
    perl Makefile.PL INSTALLDIRS=vendor
    make
}

check() {
    
    make test
}

do_package() {
    
    make DESTDIR=${pkg_prefix} install
}
