pkg_origin=cosmos

pkg_name=perl-archive-zip
_pkg_name=Archive-Zip
pkg_version=1.59
pkg_description="Provide a perl interface to ZIP archive files"
pkg_license=('GPL' 'PerlArtistic')
pkg_upstream_url="http://search.cpan.org/dist/${_pkg_name}/"
pkg_deps=('perl')
pkg_source=("http://search.cpan.org/CPAN/authors/id/P/PH/PHRED/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('b649a593391573f9382cef8c08d1d5ba')

do_build() {

  PERL_MM_USE_DEFAULT=1 perl Makefile.PL INSTALLDIRS=vendor
  make
}

do_package() {
  
  make install DESTDIR=${pkg_prefix}
}
