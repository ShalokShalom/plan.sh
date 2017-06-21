pkg_origin=cosmos

pkg_name=perl-test-pod
_pkg_name=Test-Pod
pkg_version=1.51
pkg_description="Check for POD errors in files"
pkg_license=('GPL' 'PerlArtistic')
pkg_upstream_url="http://search.cpan.org/dist/${_pkg_name}/"
pkg_deps=('perl')
pkg_source=("http://search.cpan.org/CPAN/authors/id/E/ET/ETHER/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('f806aa84de2f0c0fba48b3a5a8a4aecf')

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
