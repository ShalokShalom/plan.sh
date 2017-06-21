pkg_origin=cosmos

pkg_name=cairo-perl
pkg_version=1.081
pkg_description="Perl wrappers for cairo"
pkg_license=('LGPL')
pkg_upstream_url="http://gtk2-perl.sourceforge.net/"
pkg_deps=('cairo' 'perl')
pkg_build_deps=('perl-extutils-depends' 'perl-extutils-pkgconfig')
pkg_source=("http://downloads.sourceforge.net/sourceforge/gtk2-perl/Cairo-${pkg_version}.tar.gz")
pkg_shasum=('52c712b0f749f2fe232ae6e18880fe7d')

do_build() {
  perl Makefile.PL INSTALLDIRS=vendor
  
  make
}

check() {
  
  make test
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
