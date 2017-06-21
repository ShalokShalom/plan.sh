pkg_origin=cosmos

pkg_name=perl-error
_pkg_name=Error
pkg_version=0.17024
pkg_description="Perl/CPAN Error module - Error/exception handling in an OO-ish way"
pkg_upstream_url="http://search.cpan.org/dist/${_realname}/"
pkg_license=('PerlArtistic' 'GPL')
pkg_deps=('perl')
pkg_source=("http://search.cpan.org/CPAN/authors/id/S/SH/SHLOMIF/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('7e3676a7fb14f65f568f12d4b40a2a72')

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
  
  make DESTDIR=${pkg_prefix} install
}
