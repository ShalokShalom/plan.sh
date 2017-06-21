pkg_origin=cosmos

pkg_name=perl-file-listing
pkg_version=6.04
pkg_description="parse directory listing"
pkg_upstream_url="http://search.cpan.org/dist/File-Listing"
pkg_license=('PerlArtistic' 'GPL')
pkg_deps=('perl' 'perl-http-date')
pkg_source=("http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/File-Listing-${pkg_version}.tar.gz")
pkg_shasum=('83f636b477741f3a014585bb9cc079a6')

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
